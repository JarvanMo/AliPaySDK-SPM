# AlipaySDK for Swift Package Manager

支付宝 iOS SDK 的 Swift Package Manager 封装。目前包含：

- AlipaySDK `15.8.42`
- iOS 真机 `arm64`
- iOS 模拟器 `arm64`、`x86_64`
- 最低部署版本 iOS 12

## 安装

在 Xcode 中选择 **File > Add Package Dependencies...**，输入本仓库地址，并将
`AlipaySDK` product 添加到 App target。

也可以在另一个 `Package.swift` 中声明：

```swift
dependencies: [
    .package(
        url: "https://github.com/JarvanMo/AliPaySDK-SPM.git",
        branch: "main"
    ),
]
```

发布 `15.8.42`（或 `15.8.42.x`）版本标签后，建议业务工程改为版本依赖。

然后添加 product 依赖：

```swift
.product(name: "AlipaySDK", package: "AliPaySDK-SPM")
```

## App 配置

1. 在支付宝开放平台为应用配置 URL Scheme；App 的 `Info.plist` 中增加相同的
   `CFBundleURLSchemes`。
2. 如果使用 Universal Link，配置 Associated Domains，并在支付宝开放平台填写
   对应链接。
3. 为 `LSApplicationQueriesSchemes` 增加业务实际需要查询的支付宝 scheme；具体值以
   当前支付宝开放平台接入文档为准。
4. 订单签名必须在服务端完成。不要把应用私钥放进 iOS 客户端。

## 使用

```swift
import AlipaySDK

AlipaySDK.defaultService().payOrder(
    orderString,
    fromScheme: "your-app-scheme"
) { result in
    // resultStatus: 9000 表示客户端支付流程成功。
    // 最终交易状态仍应由服务端调用支付宝查询/异步通知进行确认。
    print(result)
}
```

处理 URL Scheme 回跳（AppDelegate 或 SceneDelegate）：

```swift
func application(
    _ app: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
) -> Bool {
    AlipaySDK.defaultService().processOrder(
        withPaymentResult: url,
        standbyCallback: { result in
            print(result)
        }
    )
    return true
}
```

处理 Universal Link 回跳：

```swift
func application(
    _ application: UIApplication,
    continue userActivity: NSUserActivity,
    restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
) -> Bool {
    AlipaySDK.defaultService().handleOpenUniversalLink(
        userActivity,
        standbyCallback: { result in
            print(result)
        }
    )
    return true
}
```

Xcode 26 及以后，SDK 要求业务显式设置展示窗口：

```swift
AlipaySDK.defaultService().targetWindow = window
```

## 资源

Package 会自动携带官方 `AlipaySDK.bundle`。如需检查资源是否正确集成，可使用：

```swift
import AlipaySDKSupport

let resourceBundle = AlipaySDKResources.bundle
```

通常业务代码不需要直接访问该 bundle。

> 本仓库仅对官方二进制 SDK 做 SPM 封装。支付宝 SDK 的使用条款、隐私合规要求及
> API 行为以支付宝官方发布内容为准。
