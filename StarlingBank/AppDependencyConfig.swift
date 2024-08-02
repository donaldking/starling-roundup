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
private let token = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty46jMBD8lRHn6VEMJgFuc9sf2A9o7HZiDdjINpkdrfbf18QmhCg3qqof1e7mb6G9L7oCJw2SRvvhA7pBm3OP5utD2LF4L_zcxwglVS_wQMDUAYE3DKFthATODjVrVauQNTGY_kxFx05leWybklfvhcaQCcaahUAh7GzCLztIcr-1zLUbUgJkjUfgnJXQN0hQVxU7VlwiVTzWDvaLTMpgdVWfDryGVvUt8JopaPqyAsbr8sTauqz7xU0c61MI8n7rUyEi9G1fAi9FBU0ljiArVfWnQ01cHZeBhZ1oeZTkFC43q2BwpM4RyrcnIfxMT4KWZIJWmtyeH7QPOyYDKV002ZHU4Q6SEgKKy0j3yA1_Ox3oDedwsU77uDLQRuqrljMOKbjHAY3I1gQ6CcKa4OyQGi1M1qxR2o0YtDVgFajZyGxAzD7YcZ2DRtQ5e0QjMVAnaaDoY4W3sJECRoSdiHARV3zLnPCHaJUSyEUS2IJAj3jONZO2fUJwaDyKxfOdhsGKOP1WOxFgl2d4ZnOWs0oPa6vUe0fdohwJ0lPYAb-X0j48XuMqPJzt5mPH5VF33K3OI5OGU_HZX5TYxBe1NjEVFReS80AS4tjbGXkKIQ44TxlOuJ5J_P_jFcVjsk4-tN-za989-yIf7Le584EWAyD89ZmapErU405vq3hecvHvPx0AO4yyBAAA.EYsLnN2a_4dFXTT_1koD-C8773NDu6g0F6JRNs6u3Wh07PEsoqUpQT3kr4yRM-bTHgaPRJ0WgpkSasdB07DV-M5v2Ui9FdnUJWoAhjEytYyPAVbFP9mD0uJNCsnH98p77dooY4n4paExOMKsUTgGVOXwk6DpFEIrJQn6yYxwq0cdjnilRbWdJcvaPsi8FyQnVlyQTMmB2hQ4eY3WWug2LE8ya1GDqyzegJMtCp8DEJvxEXO2KceHvDHGlJOnRlRFOGUcmQ_zcaXUD5ifyD8pywBk5MVgIP1_MZAnBsltJfbkcTZReWaP24rGwQcb6Yoq-WBOtZknGrH7SwV8_GiWH_VpwKtgvPUFTiFT1hxMHG5A1Iwiu7_bgvpapnbCC4vJ2o0HcqnRqgOEGd1Gu-ucGDLrpjlcY6U11IW7LS-B5BrHORBbJUsSwKASaBj0Qjlc9IARii5XqnjI2Pts8hfjJjP-PrP_pSb7jKTrNVk2N49xLDVuiJ8KS09Qp94BOgX9KRzRV4MdO1KTqhOOAT9BiFBPJ7PK7-qMMc6WcnTZ7x6HIHWeNOJqIU-S9qlnxz7JtqKpqdF3mVemqu1iAGHU-Ge75IrDaZokVyTyuYEhhhKJZNK7QWifqFzBqCCbC2V9N__G6x01Yg6b7NvfSrnRc-nCewFQhDAPefBKYmBe0mY"

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
