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
private let token = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21T23KjMAz9lQ7Pqw4GQkne9m1_YD9ASHLjKdiMbdrt7Oy_r4khlEwnL5xzdDmylL-FCaG4FDgZYBndc4joB2Nfe7Rvz-TG4kcR5j5FaNY9YSmgdInQdArh3BFDo8qTOuuzRtWlYPkzFRf1UlWtUm1X_SgMxkyc0m8hkMjNNv5yA4v_bXit3Ykm4BO20DSqgr5DgVNdq7ZuGKVuUu3o3sTmjFKfK37RAkR9nzycGVBJB22pqCmrsiVVp4w01k8iCWHvUyMi9Oe-gqaiGrqaWuBa1_1LeZJGt8vA5CZZHiU7hevNKlgc5eIF-elBiJ_Tg2BYbDTaiD_ygwnxwKyA2SeTF2ET7yArMSJdR7lH7vjDmyhPOMer8yaklYGxbN4Nzzjk4B4HtLRaI_QM5Gz0bsiNFmbVnNXGjxiNs-A06NnyaoDmEN24zSEjmjV7RMsY5cIySPKxwVvYKBETwgsluIgbvmVO-CmySRmsRTLYg8CM-LrWzNr-CdGjDUiL5zsNg6M0_V47E-CWZ3hk1yzvtBm2Vrn3gbpFeSExUzyAcJTyPgK-p1UEeHW7jwO3jnrgbnW-Mnk4nZ79mxK7-E2tXcxF6So8D8KQxt7PKEiMacB5WuGE25mk_3-6onRMzvOX9kd263tkv8kH92HvfJTFAFB4f6Qm1pn6utPbKh6XXPz7D_vELA-yBAAA.n6Y_MmBhm568dg577wTpZBBW9XmNE9j0a4TWZd48mgEe7S39KlhgQ_9H5xrBaUgZhgkw1XivXYs_e1Nst-14gnmQIQcFM5b40EZFTtP_DMBt25qEO46qF_19tkrm7USbCstMx2sT9fcoj_DPcn-d8KaFgj2YGIg_-pKJ6Fzxk0h9Xhic33goy6w42BVN7eyXZPPajhLCl0V6a5KRRZnYt67c43TPM_Bb3CrwC_7OpuK-blHewssRDpxHKwxV01tGUGQQxJHJK-DYh9DA-cbbLczaWjkOjsCv0CvYQSTAC2IxPeV1AYkP2_KifOy-18u635G03ZvUV1HlGnOqGv8Ypa2xxBFczeU-joC7F9aSWMvG76bysFqmtHcPCEoO9xNXHCWCsuKy_3S47HoCaXmlhhHNekA41FinzXU2FcYpUx1ei-SIzBEg-zzGsHGBrRf7gPnYgw_GgK7wl_irWZ8YZQ7fn5_KhAz5v1Ag-pOXrJAbJYaIDvFoxbqiqXYt1-VDkK00tLrPr-pfu2j4b1UJuAQjxxES4oVCxGwzQImPiYpfhqtQkDE8VlUyjsqro1Din3aWQImqsk3hQCjHY2cYj5rkaFZVoCWoEACAQUks3MtQOOn0FmNjH0rFai9vNul4MzvEk37XKdUpEqocm6Xuk2sRbe_CQhENcRIhzYI5apo"

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
