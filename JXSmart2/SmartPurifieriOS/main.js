require('SPUserModel,NSNumber,FTIndicator,NSMutableArray,SPToastHUD,NSMutableDictionary,SPBaseNetWorkRequst,NSArray,SPClarifierTrafficModel,NSDate');
defineClass('MyOrderViewController', {
            
            requestMyOrderList: function(currentpage) {
            
            console.log('jshotfix');
            
            self.setValue_forKey(currentpage, "_readPage")
            
            var headerView = self.valueForKey("headerView")
            var footerView = self.valueForKey("footerView")
            var tableV = self.valueForKey("tableV")
            
            var model = SPUserModel.getUserLoginModel();
            
            var weakSelf = __weak(self)
            
            var dic = {
            "uid": model.userid(),
            "page":NSNumber.numberWithInteger(currentpage)
            };
            
            self.business().getUserMyOrder_success_failer(dic, block('id', function(result) {
                                                                     
                                                                     headerView.endRefresh();
                                                                     footerView.endRefresh();
                                                                     FTIndicator.dismissProgress();
                                                                     if (currentpage == 1) {
                                                                     
                                                                     weakSelf.orderListArr().removeAllObjects();
                                                                     
                                                                     weakSelf.orderGroupListArr().removeAllObjects();
                                                                     }
                                                                     
                                                                     weakSelf.orderListArr().addObjectsFromArray(result);
                                                                     
                                                                     weakSelf.orderGroupListArr().addObjectsFromArray(result);
                                                                     
                                                                     weakSelf.setOrderGroupListArr(NSMutableArray.arrayWithArray(weakSelf.fetchTimeGroupArr(weakSelf.orderListArr())));
                                                                     
                                                                     tableV.reloadData();
                                                                     
                                                                     }),block('NSString*', function(error) {
                                                                              console.log(error);
                                                                              headerView.endRefresh();
                                                                              footerView.endRefresh();
                                                                              FTIndicator.dismissProgress();
                                                                              SPToastHUD.makeToast_duration_position_makeView(error, 2.5, null, weakSelf.view());
                                                                              
                                                                              }));
            
            
            
            }});


defineClass('JFCityViewController',{
            
            historyCity: function(city) {
            
            if(city){
            
            console.log(' historyCity jshotfix');
            
            self.ORIGhistoryCity(city);
            }
            
            },
            
            });

//defineClass('SPUserModulesBusiness',{
//            
//            getClarifierDetailCost_success_failer: function(param, successBlock, failer) {
//            
//            console.log(' getClarifierDetailCost jshotfix');
//            
//            SPBaseNetWorkRequst.startNetRequestWithTypeMethod_isNeedUserIdentifier_didParam_didUrl_didSuccess_didFailed(1, false, param, "smvc/product/myproductServiceDetail.v", block('id', function(response) {
//                                                                                                                                                                                        
//                                                                                                                                                                                        if (response.isKindOfClass(NSArray.class())) {
//                                                                                                                                                                                        
//                                                                                                                                                                                        var model = SPClarifierTrafficModel.mj__objectWithKeyValues(response.firstObject());
//                                                                                                                                                                                        
//                                                                                                                                                                                        model.setFetch__Time(NSDate.getTimeStringWithDate(NSDate.date()));
//                                                                                                                                                                                        
//                                                                                                                                                                                        if (model && successBlock) {
//                                                                                                                                                                                        
//                                                                                                                                                                                        successBlock(model);                                                                            }
//                                                                                                                                                                                        }
//                                                                                                                                                                                        
//                                                                                                                                                                                        }), block('NSString*', function(errorMsg) {
//                                                                                                                                                                                                  
//                                                                                                                                                                                                  
//                                                                                                                                                                                                  failer(errorMsg);
//                                                                                                                                                                                                  }));
//            
//            },
//            
//            });
