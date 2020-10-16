import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    app.get("hello") { req -> String in
        return "Hello, world!"
    }
    
    app.get("hello", "vapor") {req -> String in
        return "Hello Vapor!"
    }
    
    // 使用on来获取接口
    app.on(.GET, "hello", "Vapor", "OnGet") {req in
        return "on.get/hello/vapor/"
    }
    
    // 路由参数
    app.get("params", ":name") {req -> String in
        let name = req.parameters.get("name")!
        return "hello \(name)"
    }
    
    // 参数路径
    app.get("foo", ":bar", "baz") {req in
        return "参数 \(req.parameters.get("bar")!)"
    }
    
    // 任意路径
    app.get("foo", "*", "bar") { req in
        return "任意路径"
    }
    
    // 统配路径：如有重叠优先于任意路径
    app.get("foo", "**") {req -> String in
        return "通配路由\(req.parameters.getCatchall().joined(separator: " "))"
    }
    
    // 数据流
    app.on(.POST, "file-upload", body: .stream) { req in
        // 处理数据流业务
    }
    
    /*
     路由组
     */
    let users = app.grouped("users")
    users.get {req in
        
    }
    users.post {req in
        
    }
    
    users.get(":id") { req in
        let id = req.parameters.get("id")!
        return "路由组处理业务\(id)"
    }
    
    /*
     路由组-闭包处理
     */
    app.group("names") {names in
        names.get(":id") { req in
            return "路由组-闭包处理\(req.parameters.get("id"))"
        }
    }
}
