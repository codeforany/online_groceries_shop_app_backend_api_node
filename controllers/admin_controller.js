var db = require('./../helpers/db_helpers')
var helper = require('./../helpers/helpers')
var multiparty = require('multiparty')
var fs = require('fs');
var imageSavePath = "./public/img/"

const msg_success = "successfully";
const msg_fail = "fail";

module.exports.controller = (app, io, socket_list) => {


    const msg_invalidUser = "invalid username and password";
    const msg_already_register = "this email already register ";
    const msg_brand_added = "Brand added Successfully.";
    const msg_brand_update = "Brand updated Successfully.";
    const msg_brand_delete = "Brand deleted Successfully.";

    const msg_category_added = "Category added Successfully.";
    const msg_category_update = "Category updated Successfully.";
    const msg_category_delete = "Category deleted Successfully.";

    const msg_type_added = "Type added Successfully.";
    const msg_type_update = "Type updated Successfully.";
    const msg_type_delete = "Type deleted Successfully.";

    const msg_product_added = "Product added Successfully.";
    const msg_product_update = "Product updated Successfully.";
    const msg_product_delete = "Product deleted Successfully.";

    const msg_nutrition_added = "nutrition added Successfully.";
    const msg_nutrition_update = "nutrition updated Successfully.";
    const msg_nutrition_delete = "nutrition deleted Successfully.";

    const msg_product_image_added = "Product image added Successfully.";
    const msg_product_image_delete = "Product image deleted Successfully.";

    const msg_already_added = "this value already added here";

    app.post('/api/admin/brand_add', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["brand_name"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("SELECT `brand_id`, `brand_name` FROM `brand_detail` WHERE `brand_name`  = ? AND `status` = ?", [reqObj.brand_name, "1"], (err, result) => {
                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.length > 0) {
                        //already added this brand

                        res.json({ "status": "1", "payload": result[0], "message": msg_already_added });

                    } else {
                        db.query("INSERT INTO `brand_detail`( `brand_name`, `created_date`, `modify_date`) VALUES (?, NOW(), NOW())", [
                            reqObj.brand_name
                        ], (err, result) => {

                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return;
                            }

                            if (result) {
                                res.json({
                                    "status": "1", "payload": {
                                        "brand_id": result.insertId,
                                        "brand_name": reqObj.brand_name,
                                    }, "message": msg_brand_added
                                });
                            } else {
                                res.json({ "status": "0", "message": msg_fail })
                            }

                        })

                    }
                })

            }, "2")
        })
    })

    app.post('/api/admin/brand_update', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["brand_id", "brand_name"], () => {

            checkAccessToken(req.headers, res, (uObj) => {


                db.query("UPDATE `brand_detail` SET `brand_name`= ?, `modify_date` = NOW() WHERE `brand_id`= ? AND `status` = ? ", [
                    reqObj.brand_name, reqObj.brand_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_brand_update
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })



            }, "2")
        })
    })

    app.post('/api/admin/brand_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["brand_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("UPDATE `brand_detail` SET `status`= ?, `modify_date` = NOW() WHERE `brand_id`= ? ", [
                    "2", reqObj.brand_id,
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_brand_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/brand_list', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `brand_id`, `brand_name` FROM `brand_detail` WHERE `status`= ? ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });
            })
        }, "2")
    })

    app.post("/api/admin/product_category_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["cat_name", "color"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "category/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            } else {
                                db.query("INSERT INTO `category_detail`( `cat_name`, `image`, `color`, `created_date`, `modify_date`) VALUES  (?,?,?, NOW(), NOW())", [
                                    reqObj.cat_name[0], imageFileName, reqObj.color[0]
                                ], (err, result) => {

                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return;
                                    }

                                    if (result) {
                                        res.json({
                                            "status": "1", "payload": {
                                                "cat_id": result.insertId,
                                                "cat_name": reqObj.cat_name[0],
                                                "color": reqObj.color[0],
                                                "image": helper.ImagePath() + imageFileName,
                                            }, "message": msg_category_added
                                        });
                                    } else {
                                        res.json({ "status": "0", "message": msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post("/api/admin/product_category_update", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["cat_id", "cat_name", "color"], () => {

                    var condition = "";
                    var imageFileName = "";

                    if (files.image != undefined || files.image != null) {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        imageFileName = "category/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        condition = " `image` = '" + imageFileName + "', ";
                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err);
                                return
                            } else {

                            }
                        })
                    }


                    db.query("UPDATE `category_detail` SET `cat_name`=?," + condition + " `color`=?,`modify_date`=NOW() WHERE `cat_id`= ? AND `status` = ?", [
                        reqObj.cat_name[0], reqObj.color[0], reqObj.cat_id[0], "1"
                    ], (err, result) => {

                        if (err) {
                            helper.ThrowHtmlError(err, res);
                            return;
                        }

                        if (result) {
                            res.json({
                                "status": "1", "payload": {
                                    "cat_id": parseInt(reqObj.cat_id[0]),
                                    "cat_name": reqObj.cat_name[0],
                                    "color": reqObj.color[0],
                                    "image": helper.ImagePath() + imageFileName,
                                }, "message": msg_category_update
                            });
                        } else {
                            res.json({ "status": "0", "message": msg_fail })
                        }

                    })
                })

            })

        })
    })

    app.post('/api/admin/product_category_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["cat_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("UPDATE `category_detail` SET `status`= ?, `modify_date` = NOW() WHERE `cat_id`= ? ", [
                    "2", reqObj.cat_id,
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_category_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_category_list', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `cat_id`, `cat_name`,  (CASE WHEN `image` != '' THEN CONCAT('" + helper.ImagePath() + "','',`image`)  ELSE `image` END) AS `image` , `color` FROM `category_detail` WHERE `status`= ? ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });
            })
        }, "2")
    })

    app.post("/api/admin/product_type_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["type_name", "color"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "type/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            } else {
                                db.query("INSERT INTO `type_detail`( `type_name`, `image`, `color`, `created_date`, `modify_date`) VALUES  (?,?,?, NOW(), NOW())", [
                                    reqObj.type_name[0], imageFileName, reqObj.color[0]
                                ], (err, result) => {

                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return;
                                    }

                                    if (result) {
                                        res.json({
                                            "status": "1", "payload": {
                                                "type_id": result.insertId,
                                                "type_name": reqObj.type_name[0],
                                                "color": reqObj.color[0],
                                                "image": helper.ImagePath() + imageFileName,
                                            }, "message": msg_type_added
                                        });
                                    } else {
                                        res.json({ "status": "0", "message": msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post("/api/admin/product_type_update", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["type_id", "type_name", "color"], () => {

                    var condition = "";
                    var imageFileName = "";

                    if (files.image != undefined || files.image != null) {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        imageFileName = "type/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        condition = " `image` = '" + imageFileName + "', ";
                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err);
                                return
                            } else {

                            }
                        })
                    }


                    db.query("UPDATE `type_detail` SET `type_name`=?," + condition + " `color`=?,`modify_date`=NOW() WHERE `type_id`= ? AND `status` = ? ", [
                        reqObj.type_name[0], reqObj.color[0], reqObj.type_id[0], "1"
                    ], (err, result) => {

                        if (err) {
                            helper.ThrowHtmlError(err, res);
                            return;
                        }

                        if (result) {
                            res.json({
                                "status": "1", "payload": {
                                    "type_id": parseInt(reqObj.type_id[0]),
                                    "type_name": reqObj.type_name[0],
                                    "color": reqObj.color[0],
                                    "image": helper.ImagePath() + imageFileName,
                                }, "message": msg_type_update
                            });
                        } else {
                            res.json({ "status": "0", "message": msg_fail })
                        }

                    })
                })

            })

        })
    })

    app.post('/api/admin/product_type_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["type_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("UPDATE `type_detail` SET `status`= ?, `modify_date` = NOW() WHERE `type_id`= ? ", [
                    "2", reqObj.type_id,
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_type_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_type_list', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `type_id`, `type_name`,  (CASE WHEN `image` != '' THEN CONCAT('" + helper.ImagePath() + "','',`image`)  ELSE `image` END) AS `image` , `color` FROM `type_detail` WHERE `status`= ? ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });
            })
        }, "2")
    })

    app.post("/api/admin/product_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["name", "detail", "cat_id", "brand_id", "type_id", "unit_name", "unit_value", "nutrition_weight", "price", "nutrition_date"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var imageNamePathArr = []
                        var fullImageNamePathArr = [];
                        files.image.forEach(imageFile => {
                            var extension = imageFile.originalFilename.substring(imageFile.originalFilename.lastIndexOf(".") + 1);
                            var imageFileName = "product/" + helper.fileNameGenerate(extension);

                            imageNamePathArr.push(imageFileName);
                            fullImageNamePathArr.push(helper.ImagePath() + imageFileName);
                            saveImage(imageFile, imageSavePath + imageFileName);
                        });

                        helper.Dlog(imageNamePathArr);
                        helper.Dlog(fullImageNamePathArr);

                        db.query("INSERT INTO `product_detail`(`cat_id`, `brand_id`, `type_id`, `name`, `detail`, `unit_name`, `unit_value`, `nutrition_weight`, `price`, `created_date`, `modify_date`) VALUES (?,?,?, ?,?,?, ?,?,?, NOW(), NOW() ) ", [reqObj.cat_id[0], reqObj.brand_id[0], reqObj.type_id[0], reqObj.name[0], reqObj.detail[0], reqObj.unit_name[0], reqObj.unit_value[0], reqObj.nutrition_weight[0], reqObj.price[0]], (err, result) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            }

                            if (result) {



                                var nutritionInsertData = []

                                var nutritionDataArr = JSON.parse(reqObj.nutrition_date[0])

                                nutritionDataArr.forEach(nObj => {
                                    nutritionInsertData.push([result.insertId, nObj.name, nObj.value]);
                                });



                                if (nutritionDataArr.length > 0) {
                                    db.query("INSERT INTO `nutrition_detail`(`prod_id`, `nutrition_name`, `nutrition_value`) VALUES ? ", [nutritionInsertData], (err, nResult) => {
                                        if (err) {
                                            helper.ThrowHtmlError(err, res);
                                            return
                                        }

                                        if (nResult) {
                                            helper.Dlog(" nutritionInsert succes");
                                        } else {
                                            // res.json({ "status": "0", "message": msg_fail })
                                            helper.Dlog(" nutritionInsert fail");
                                        }


                                    })
                                }

                                var imageInsertArr = []

                                imageNamePathArr.forEach(imagePath => {
                                    imageInsertArr.push([result.insertId, imagePath]);
                                });

                                db.query("INSERT INTO `image_detail`(`prod_id`, `image`) VALUES ? ", [imageInsertArr], (err, iResult) => {
                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return
                                    }

                                    if (iResult) {
                                        helper.Dlog(" imageInsertArr succes");
                                    } else {
                                        helper.Dlog(" imageInsertArr fail");
                                    }

                                })


                                res.json({
                                    "status": "1", "message": msg_product_added
                                });

                            } else {
                                res.json({ "status": "0", "message": msg_fail })
                            }
                        })


                    })
                })

            })

        })
    })

    app.post('/api/admin/product_update', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "name", "detail", "cat_id", "brand_id", "type_id", "unit_name", "unit_value", "nutrition_weight", "price"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `product_detail` SET `cat_id`=?,`brand_id`=?,`type_id`=?,`name`=?,`detail`=?,`unit_name`=?,`unit_value`=?,`nutrition_weight`=?,`price`=?, `modify_date`=NOW() WHERE  `prod_id`= ? AND `status` = ? ", [
                    reqObj.cat_id, reqObj.brand_id, reqObj.type_id, reqObj.name, reqObj.detail, reqObj.unit_name, reqObj.unit_value, reqObj.nutrition_weight, reqObj.price, reqObj.prod_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_product_update
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `product_detail` SET `status`=?,`modify_date`=NOW() WHERE  `prod_id`= ? AND `status` = ? ", [
                    "2", reqObj.prod_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_product_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_nutrition_add', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "nutrition_name", "nutrition_value"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("INSERT INTO `nutrition_detail`( `prod_id`, `nutrition_name`, `nutrition_value`, `created_date`, `modify_date`) VALUES (?,?,?, NOW(), NOW())", [
                    reqObj.prod_id, reqObj.nutrition_name, reqObj.nutrition_value
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result) {
                        res.json({
                            "status": "1", "message": msg_nutrition_added
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })



            }, "2")
        })
    })

    app.post('/api/admin/product_nutrition_update', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "nutrition_id", "nutrition_name", "nutrition_value"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `nutrition_detail` SET `nutrition_name`= ?,`nutrition_value`= ?, `modify_date`= NOW() WHERE  `prod_id`= ? AND `nutrition_id` = ? AND `status` = ? ", [
                    reqObj.nutrition_name, reqObj.nutrition_value, reqObj.prod_id, reqObj.nutrition_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_nutrition_update
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_nutrition_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "nutrition_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {

                db.query("UPDATE `nutrition_detail` SET `status`= ?, `modify_date`= NOW() WHERE  `prod_id`= ? AND `nutrition_id` = ? AND `status` = ? ", [
                    "2", reqObj.prod_id, reqObj.nutrition_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_nutrition_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post("/api/admin/product_image_add", (req, res) => {
        var form = new multiparty.Form();

        checkAccessToken(req.headers, res, (uObj) => {

            form.parse(req, (err, reqObj, files) => {
                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return
                }

                helper.Dlog("---------- Parameter ----")
                helper.Dlog(reqObj)
                helper.Dlog("---------- Files ----")
                helper.Dlog(files)

                helper.CheckParameterValid(res, reqObj, ["prod_id"], () => {
                    helper.CheckParameterValid(res, files, ["image"], () => {
                        var extension = files.image[0].originalFilename.substring(files.image[0].originalFilename.lastIndexOf(".") + 1);

                        var imageFileName = "product/" + helper.fileNameGenerate(extension);
                        var newPath = imageSavePath + imageFileName;

                        fs.rename(files.image[0].path, newPath, (err) => {
                            if (err) {
                                helper.ThrowHtmlError(err, res);
                                return
                            } else {
                                db.query("INSERT INTO `image_detail`( `prod_id`, `image`, `created_date`, `modify_date`) VALUES  (?,?, NOW(), NOW())", [
                                    reqObj.prod_id[0], imageFileName
                                ], (err, result) => {

                                    if (err) {
                                        helper.ThrowHtmlError(err, res);
                                        return;
                                    }

                                    if (result) {
                                        res.json({
                                            "status": "1", "message": msg_product_image_added
                                        });
                                    } else {
                                        res.json({ "status": "0", "message": msg_fail })
                                    }

                                })
                            }
                        })
                    })
                })

            })

        })
    })

    app.post('/api/admin/product_image_delete', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;

        helper.CheckParameterValid(res, reqObj, ["prod_id", "img_id"], () => {

            checkAccessToken(req.headers, res, (uObj) => {
                db.query("UPDATE `image_detail` SET `status`= ?, `modify_date` = NOW() WHERE `prod_id`= ? AND `img_id` = ? AND `status` = ? ", [
                    "2", reqObj.prod_id, reqObj.img_id, "1"
                ], (err, result) => {

                    if (err) {
                        helper.ThrowHtmlError(err, res);
                        return;
                    }

                    if (result.affectedRows > 0) {
                        res.json({
                            "status": "1", "message": msg_product_image_delete
                        });
                    } else {
                        res.json({ "status": "0", "message": msg_fail })
                    }

                })
            }, "2")
        })
    })

    app.post('/api/admin/product_list', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;


        checkAccessToken(req.headers, res, (uObj) => {
            db.query("SELECT `pd`.`prod_id`, `pd`.`cat_id`, `pd`.`brand_id`, `pd`.`type_id`, `pd`.`name`, `pd`.`detail`, `pd`.`unit_name`, `pd`.`unit_value`, `pd`.`nutrition_weight`, `pd`.`price`, `pd`.`created_date`, `pd`.`modify_date`, `cd`.`cat_name`, IFNULL( `bd`.`brand_name`, '' ) AS `brand_name` , `td`.`type_name` FROM `product_detail` AS  `pd` " +
                "INNER JOIN `category_detail` AS `cd` ON `pd`.`cat_id` = `cd`.`cat_id` " +
                "LEFT JOIN `brand_detail` AS `bd` ON `pd`.`brand_id` = `bd`.`brand_id` " +
                "INNER JOIN `type_detail` AS `td` ON `pd`.`type_id` = `td`.`type_id` " +
                " WHERE `pd`.`status` = ? ORDER BY `pd`.`prod_id` DESC ", [
                "1"
            ], (err, result) => {

                if (err) {
                    helper.ThrowHtmlError(err, res);
                    return;
                }

                res.json({
                    "status": "1", "payload": result
                });

            })
        }, "2")

    })

    app.post('/api/admin/product_detail', (req, res) => {
        helper.Dlog(req.body);
        var reqObj = req.body;
        checkAccessToken(req.headers, res, (uObj) => {
            helper.CheckParameterValid(res, reqObj, ["prod_id"], () => {

                getProductDetail(res, reqObj.prod_id);
               
            })
        }, "2")

    })

    function getProductDetail(res, prod_id) {
        db.query("SELECT `pd`.`prod_id`, `pd`.`cat_id`, `pd`.`brand_id`, `pd`.`type_id`, `pd`.`name`, `pd`.`detail`, `pd`.`unit_name`, `pd`.`unit_value`, `pd`.`nutrition_weight`, `pd`.`price`, `pd`.`created_date`, `pd`.`modify_date`, `cd`.`cat_name`, IFNULL( `bd`.`brand_name`, '' ) AS `brand_name` , `td`.`type_name` FROM `product_detail` AS  `pd` " +
            "INNER JOIN `category_detail` AS `cd` ON `pd`.`cat_id` = `cd`.`cat_id` " +
            "LEFT JOIN `brand_detail` AS `bd` ON `pd`.`brand_id` = `bd`.`brand_id` " +
            "INNER JOIN `type_detail` AS `td` ON `pd`.`type_id` = `td`.`type_id` " +
            " WHERE `pd`.`status` = ? AND `pd`.`prod_id` = ? ; " +
            
            " SELECT `nutrition_id`, `prod_id`, `nutrition_name`, `nutrition_value` FROM `nutrition_detail` WHERE `prod_id` = ? AND `status` = ? ORDER BY `nutrition_name`;" +
            
            
            "SELECT `img_id`, `prod_id`, `image` FROM `image_detail` WHERE `prod_id` = ? AND `status` = ? ", [



            "1", prod_id, prod_id, "1", prod_id, "1",

        ], (err, result) => {

            if (err) {
                helper.ThrowHtmlError(err, res);
                return;
            }

            // result = result.replace_null()

            // helper.Dlog(result);
            
            if(result[0].length > 0) {

                result[0][0].nutrition_list = result[1];
                result[0][0].images = result[2];


                res.json({  
                    "status": "1", "payload": result[0][0]
                });
            }else{
                res.json({ "status": "0", "message": "invalid item" })
            }

            

        })
    }


}

function saveImage(imageFile, savePath) {
    fs.rename(imageFile.path, savePath, (err) => {

        if (err) {
            helper.ThrowHtmlError(err);
            return;
        }
    })
}

function checkAccessToken(headerObj, res, callback, require_type = "") {
    helper.Dlog(headerObj.access_token);
    helper.CheckParameterValid(res, headerObj, ["access_token"], () => {
        db.query("SELECT `user_id`, `username`, `user_type`, `name`, `email`, `mobile`, `mobile_code`,  `auth_token`, `dervice_token`, `status` FROM `user_detail` WHERE `auth_token` = ? AND `status` = ? ", [headerObj.access_token, "1"], (err, result) => {
            if (err) {
                helper.ThrowHtmlError(err, res);
                return
            }

            helper.Dlog(result);

            if (result.length > 0) {
                if (require_type != "") {
                    if (require_type == result[0].user_type) {
                        return callback(result[0]);
                    } else {
                        res.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access." })
                    }
                } else {
                    return callback(result[0]);
                }
            } else {
                res.json({ "status": "0", "code": "404", "message": "Access denied. Unauthorized user access." })
            }
        })
    })
}