var db = require('./../helpers/db_helpers')
var helper = require('./../helpers/helpers')
// var multiparty = require(multiparty)
var imageSavePath = "./public/img/"



module.exports.controller = (app, io, socket_list) => {

    const msg_success = "successfully";
    const msg_fail = "fail";
    const msg_invalidUser = "invalid username and password";
    const msg_already_register = "this email already register ";

    app.post('/api/login', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["email", "password", "dervice_token"], () => {

            var auth_token = helper.createRequestToken();
            db.query("UPDATE `user_detail` SET `auth_token`= ?,`dervice_token`=?,`modify_date`= NOW() WHERE `email` = ? AND `password` = ? AND `status` = ?", [auth_token, reqObj.dervice_token, reqObj.email, reqObj.password, "1"], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                if (result.affectedRows > 0) {


                    db.query('SELECT `user_id`, `username`, `name`, `email`, `mobile`, `mobile_code`, `password`, `auth_token`, `status`, `created_date` FROM `user_detail` WHERE `email` = ? AND `password` = ? AND `status` = "1" ', [reqObj.email, reqObj.password], (err, result) => {

                        if (err) {
                            helper.ThrowHtmlError(err, res);
                            return
                        }

                        if (result.length > 0) {
                            res.json({ "status": "1", "payload": result[0], "message": msg_success })
                        } else {
                            res.json({ "status": "0", "message": msg_invalidUser })
                        }
                    })
                } else {
                    res.json({ "status": "0", "message": msg_invalidUser })
                }

            })
        })
    })

    app.post('/api/sign_up', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["username", "email", "password", "dervice_token"], () => {

            db.query('SELECT `user_id`, `status` FROM `user_detail` WHERE `email` = ? ', [reqObj.email], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                if (result.length > 0) {
                    res.json({ "status": "1", "payload": result[0], "message": msg_already_register })
                } else {

                    var auth_token = helper.createRequestToken();
                    db.query("INSERT INTO `user_detail`( `username`, `email`, `password`, `auth_token`, `dervice_token`, `created_date`, `modify_date`) VALUES (?,?,?, ?,?, NOW(), NOW())", [reqObj.username, reqObj.email, reqObj.password, auth_token, reqObj.dervice_token  ], (err, result) => {
                        if (err) {
                            helper.ThrowHtmlError(err, res);
                            return
                        }

                        if(result) {
                            db.query('SELECT `user_id`, `username`, `name`, `email`, `mobile`, `mobile_code`, `password`, `auth_token`, `status`, `created_date`  FROM `user_detail` WHERE `user_id` = ? AND `status` = "1" ', [result.insertId], (err, result) => {

                                if (err) {
                                    helper.ThrowHtmlError(err, res);
                                    return
                                }

                                if (result.length > 0) {
                                    res.json({ "status": "1", "payload": result[0], "message": msg_success })
                                } else {
                                    res.json({ "status": "0", "message": msg_invalidUser })
                                }
                            })
                        }else{
                            res.json({ "status": "0", "message": msg_fail })
                        }
                    } )
                    
                }
            })
        })
    })
}

function checkAccessToken(headerObj, res, callback, require_type = "") {
    helper.Dlog(headerObj.access_token);
    helper.CheckParameterValid(res, headerObj, ["access_token"] , () => {
        db.query("SELECT `user_id`, `username`, `user_type`, `name`, `email`, `mobile`, `mobile_code`,  `auth_token`, `dervice_token`, `status` FROM `user_detail` WHERE `auth_token` = ? AND `status` = ? ", [headerObj.access_token, "1"], (err, result) => {
            if(err) {
                helper.ThrowHtmlError(err, res);
                return
            }

            helper.Dlog(result);

            if(result.length > 0) {
                if (require_type != "") {
                    if(require_type == result[0].user_type) {
                        return callback(result[0]);
                    } else {
                        res.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access." })
                    }
                }else{
                    return callback(result[0]);
                }
            }else{
                res.json({ "status": "0", "code":"404" , "message": "Access denied. Unauthorized user access."})
            }
        })
    })
}