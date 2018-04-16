#NEWSmartSmartPurifieriOS

readme:代码是俩个人写的，主框架是采用mvc+模块化的思路所搭。另外一个人写的有点坑，我只改了一部分，如果这个项目还有人接手，就靠你改了 0.0 .下面是层次说明

Classess - 主代码存放区
    BASE - 基类
        BASECONTROLLER
        BASEMODEL
    ENGINES - 网络处理、支付处理、缓存处理、加解密处理
        SPBaseNetWorkRequst
        SPBaseResponseHandler
        SPBaseBusiness
    MODULES - 单元模块
        MAIN - 主模块
            MODELS - 模型
            VIEWCONTROLLERS - 
            VIEWS
            BUSINESS - 网络请求业务、数据处理
            COMMON
            STORYBOARDS
        HOMEPAGE 
        COMMUNITYSERVICE
        USER
    CUSTOMVIEWS - 自定义的view
    CATEGORYS   - 一些分类
    PODSENCAPSULATION - cocoapods一些常用接口封装
    Vendor - 第三方
RESOURXE - 资源存放区


关于环境的配置 打包时需要区分 Release优先级最高
    SmartPurifierHostURL_For_Develop
    SmartPurifierHostURL_For_BetaTest
    SmartPurifierHostURL_For_Release



by. Wind
