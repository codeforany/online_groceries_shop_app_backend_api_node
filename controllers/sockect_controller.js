var helper = require('./../helpers/helpers')
var db = require('./../helpers/db_helpers')

module.exports.controller = (app, io, socket_list) => {
    var response = '';

    const msg_success = "successfully";
    const msg_fail = "fail";
    const msg_invalidUser = "invalid username and password";

    io.on('connection', (client) => {
        client.on('UpdateSocket', (data) => {
            helper.Dlog('UpdateSocket :- ' + data);
            var jsonObj = JSON.parse(data);

            helper.CheckParameterValidSocket(client, "UpdateSocket",  jsonObj, ['user_id'], () => {
                db.query("SELECT `user_id`, `email` FROM `user_detail` WHERE `user_id` = ?;", [jsonObj.user_id], (err, result) => {

                    if(err) {
                        helper.ThrowSocketError(err, client, "UpdateSocket")
                        return;
                    }

                    if(result.length > 0) {
                        socket_list['us_' + jsonObj.user_id] = { 'socket_id': client.id}

                        helper.Dlog(socket_list);
                        response = { "success": "true", "status": "1", "message": msg_success }
                    }else{
                        response = {"success":"false", "status":"0", "message": msg_invalidUser}
                    }
                    client.emit('UpdateSocket', response)
                })
            })

        })
    })


}