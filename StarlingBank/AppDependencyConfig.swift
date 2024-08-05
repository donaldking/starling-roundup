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
private let token = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty46jMBD8lRHn6RHYEAi3ue0P7Ac0djuxBmxkm8yOVvvvazCEEOVGVfWj2t38zbT3WZvhqEHSYD98QNdrc-nQfH0IO2TvmZ-6GKGk6gTmBIXKEcqmQDg3QkJZ5FVxVmeFRROD6c-YtUXN2LnI85K9ZxpDIhrGTzOBQtjJhF-2l-R-a7nWbkgJkBWeoCwLBl2DBBXnxYmXEomXsXawX2RSBmNK1Sxm1EVdQJmfOWBTMcCcd1WpJMtrFjPiWJ9CkPd7H46I0J07BiUTHBouTiC54l2dV1Sq0zywsCPNj5KcwnWxCgYHah2hfHsSws_4JGhJJmilyR35XvtwYFYgpYsmW5I63EFSQkBxHegeueNvpwO94RSu1mkfVwbaSH3TcsI-BXfYoxGrNYFOgrAmONunRjOzatYo7QYM2hqwCtRk5GpATD7YYZuDBtRr9oBGYqBWUk_RxwaXsIECRoStiHAWN7xkjvhDtEkJrEUS2INAD3hZayZt_4Tg0HgUs-c7Db0Vcfq9diLAzs_wzK5Zzirdb61S7wO1RDkSpMdwAP4opX14vMVVeLjY3ceBW0c9cEudRyYNp-Kzvyixiy9q7WIqKq4kp54kxLH3M_IUQhxwGlc44nYm8f-PVxSPyTr50P7Ibn2P7It8sN_mzgeaDYDwt2dqlCpRjztdVvG85Ozff1_n0KuyBAAA.ZpDyhcjadRuBVmYy78UU7oBbSstI2HjQ3TglTP2Pk2BvIPxhx7r3c36L0Dw6poxBs9um2lPhVD2LbIjmrsBrSYL-MtiK4Dy25bApt1J6Z8G716A-wwvW_ySyTgOEagBCIUx_aXMVp9CR_grGDNN3k-1pIXEMGpz23bX4FDZAQYecEpcs-Tdq2L46bQEZCXcu4HLmYXANXU7ZnmT6eIPJmaAIVlomq2hJVVCNDHB35Cj17Sk15rDj77V2ZCVGUFpnuovk2248Aa1nfNzwKkSYa6Z92oRbzYBAZk3shjCfU_AaiayzFpSt9y3ORxhHw0WWIGL31Hzfqz4Y5xQoWZ3SsgR28PkmvF90Zn7ZBlV8AMIVPDkSKf-3IBcSqWiijTHAG3JUIb-_TpQ1JV7CIACWB1CRV9_-Hm3kxPTxJL5-aMobXGPOB8DsAfMzGe_nUnSomIbDqdA73tNG4512Oi-S8fsDyG1kwmRP9FyXc72SQAb-24x8Qxk_VnI0Z-kuBpkgpIJGdRDHVD-0ZSOfba6szcXmLclQFG_SS5heAX24RiR5prRLe_kHIYVaA2R6VmXsNIFHckZZisA208r1q1l5BN5cB4viaO0sOXwr3AJe28-C3cFy4Dwlc-g2FGfEtA_O4jqnaFQy6WOBkJSQ4ySS0kUcfUi0BhAGWmHpsDJtLNQ"

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
