import SBDependencyContainer
import SBAccount
import SBAccountInterface
import SBTransaction
import SBTransactionInterface
import SBSavingsGoal
import SBSavingsGoalInterface
import SBWebClient
import SBWebClientInterface

// MARK: - IMPORTANT!! Please change this token to YOUR OWN token. Developer tokens expires after 24hrs. Refresh token was not implemented in this sample app.
private let token = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21T23KjMAz9lQ7PVSeAQ0je-rY_sB8gJLnxFGzGNu12dvbf18QQSqZvnHN0ObLE38KEUFwKHA2wDO4lRPS9sW8d2vcXckPxXISpSxGadUd4ECj1AUG1JcK5JQZVHo7lWZ81lm0Klj9jcSlPVXU6l-2pfi4MxoU4HNVMIJGbbPzlehb_2_BSuxVNwEdsQKmygq5FgWNdl02tGKVWqXZ072JzRtkpVk3XQtuSBtVQl9xUBJVqjqemas9c6ZSRxnolkhC2PjUiQnfuKlAV1dDW1ADXuu6SP1G6mQcmN8r8KNkpXG9WweIgFy_ITw9C_BofBMNio9FG_J7vTYg7ZgHMPpm8CJt4B1mJEek6yD1yw5_eRHnCKV6dNyGtDIxl82F4wj4Hd9ijpcUaoWcgZ6N3fW40M4vmrDZ-wGicBadBT5YXAzSF6IZ1DhnQLNkDWsYoF5Zeko8V3sIGiZgQXijBWVzxLXPEL5FVymApksEWBGbAt6Vm1rZPiB5tQJo932noHaXpt9qZADc_wyO7ZHmnTb-2yr131C3KC4kZ4w6EvZT3EfAjrSLAm9t87Lhl1B13q_OdycPp9Ow_lNjEH2ptYi5KV-GpF4Y09nZGQWJMA07jAkdczyT9_-mK0jE5z9_a79m17579IR_cp73zUWYDQOHjkRpZZ-r7Tm-reFxy8e8_NMa6iLIEAAA.biIs-1Uyhz85kz0YG5Uot8M7DZl9VXZ1q4PfhITVPqymKwngQV9k-hYdwOUyVhDeeWnWjuQy91LZaP8aXrH_5LGAPD55fM6-qUgf2eLBZMJRyUCtPPtH7qTDWq5GkSQxA4jOPYU0wqgdiY3In6TVtJe_Rex-1GB7jPY_m2XnKpIRcSd5r5RfJVIeJobF6cGf57SFAusjA4DHGSA-uU9wUfsaHVyz2JeiXLyD2CaRru-HKFogHh2IarWDORBW9bOZbSOqDTa_ALiq3g9DJaJaTwOCWPOjhyJRhL9YVdAmDfG6TceLLr84kQH6FhTDWPLIKCbCla4MKdfLVhHyWqf-l-eGEr5zQwryCiNAxuz83KlB3noFkjZzabJRyI9LUdieMv1WAk1RZaLkAqKYhoX-57hja8e4VT0wgawVpGsZZqDIQeE1yLZPVbHExD3nPQLBhGdxMGFFVgVmY-D-i4BDcIvjZ20tLJyV88D0dlMyQ9HwKi7LG0gLfrrgn6uxrOY1u_y6a6VbbBZHHezpUsqDMbNJiM8lzWlqoZd7GItFJXngY135PLXgLiFVY8xn3rV1B5wrrw14n6zpAxW4tBNJHW9Xkf9ZXEIWOhhLQDi5pfBMVcSX2PceX0Q4qaWBL-7sB2qZsBo3p6S7uSG8Mi_iogtfVQDobNW4-kUmIsLD2aw"

enum AppDependencyConfig {
    static func configure() {
        // Register accounts module gateway
        let accountGatewayClosure: () -> SBAccountInterface = { AccountModuleGateway() }
        DC.shared.register(dependency: .closure(accountGatewayClosure), for: SBAccountInterface.self)
        
        // Register transactions module gateway
        let transactionGatewayClosure: () -> SBTransactionInterface = { TransactionModuleGateway() }
        DC.shared.register(dependency: .closure(transactionGatewayClosure), for: SBTransactionInterface.self)
        
        // Register savings goals module gateway
        let savingsGoalGatewayClosure: () -> SBSavingsGoalInterface = { SavingsGoalModuleGateway() }
        DC.shared.register(dependency: .closure(savingsGoalGatewayClosure), for: SBSavingsGoalInterface.self)
        
        // Register web client
        let webClient = SBWebClient.shared
        webClient.setToken(token: token)
        DC.shared.register(dependency: .singleInstance(webClient), for: SBWebClientInterface.self)
    }
}
