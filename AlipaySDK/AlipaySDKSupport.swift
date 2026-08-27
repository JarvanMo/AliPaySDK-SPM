@_exported import AlipaySDK
import Foundation

/// Access to resources shipped with the Alipay SDK binary.
public enum AlipaySDKResources {
    /// The original `AlipaySDK.bundle` supplied with the binary SDK.
    public static let bundle: Bundle = {
        guard
            let url = Bundle.module.url(
                forResource: "AlipaySDK",
                withExtension: "bundle"
            ),
            let bundle = Bundle(url: url)
        else {
            return .module
        }

        return bundle
    }()
}
