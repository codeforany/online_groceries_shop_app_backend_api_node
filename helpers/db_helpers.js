var mysql = require('mysql')
var config = require('config')
var dbConfig = config.get('dbConfig')
var db = mysql.createConnection(dbConfig);
var helper = require('./helpers')

if(config.has('optionalFeature.detail')) {
    var detail = config.get('optionalFeature.detail');
    helper.Dlog('config: ' + detail);
}

reconnect(db, () => {});

function reconnect(connection, callback) {
    helper.Dlog("\n New connection tentative ... (" + helper.serverYYYYMMDDHHmmss() + ")" )

    connection = mysql.createConnection(dbConfig);
    connection.connect((err) => {
        if(err) {
            helper.ThrowHtmlError(err);

            setTimeout(() => {
                helper.Dlog('----------------- DB ReConnecting Error (' + helper.serverYYYYMMDDHHmmss() + ') ....................' );

                reconnect(connection, callback);
            }, 5 * 1000);
        }else{
            helper.Dlog('\n\t ----- New Connection established with database. -------');
            db = connection;
            return callback();
        }
    } )

    connection.on('error', (err) => {
        helper.Dlog('----- App is connection Crash DB Helper (' + helper.serverYYYYMMDDHHmmss() + ') -------');

        if (err.code === "PROTOCOL_CONNECTION_LOST") {
            helper.Dlog("/!\\ PROTOCOL_CONNECTION_LOST Cannot establish a connection with the database. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_ENQUEUE_AFTER_QUIT") {
            helper.Dlog("/!\\ PROTOCOL_ENQUEUE_AFTER_QUIT Cannot establish a connection with the database. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR") {
            helper.Dlog("/!\\ PROTOCOL_ENQUEUE_AFTER_FATAL_ERROR Cannot establish a connection with the database. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_ENQUEUE_HANDSHAKE_TWICE") {
            helper.Dlog("/!\\ PROTOCOL_ENQUEUE_HANDSHAKE_TWICE Cannot establish a connection with the database. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "ECONNREFUSED") {
            helper.Dlog("/!\\ ECONNREFUSED Cannot establish a connection with the database. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        } else if (err.code === "PROTOCOL_PACKETS_OUT_OF_ORDER") {
            helper.Dlog("/!\\ PROTOCOL_PACKETS_OUT_OF_ORDER Cannot establish a connection with the database. /!\\ (" + err.code + ")");
            reconnect(db, callback);
        }  else {
            throw err;
        }
    })

}

module.exports = {
    query: (sqlQuery, args, callback) => {

        if(db.state === 'authenticated' || db.state === "connected") {
            db.query(sqlQuery, args, (error, result) => {
                return callback(error, result);
            })
        }else if ( db.state === "protocol_error" ) {
            reconnect(db, () => {
                db.query(sqlQuery, args, (error, result) => {
                    return callback(error, result);
                })
            })
        }else{
            reconnect(db, ()=>{
                db.query(sqlQuery, args, (error, result ) => {
                    return callback(error, result);
                } )
            })
        }

    }
}

process.on('uncaughtException', (err) => {

    helper.Dlog('------------------------ App is Crash DB helper (' + helper.serverYYYYMMDDHHmmss() + ')-------------------------' );
    helper.Dlog(err.code);
    helper.ThrowHtmlError(err);
})
