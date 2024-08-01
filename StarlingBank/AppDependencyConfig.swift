import SBDependencyContainer
import SBAccount
import SBAccountInterface
import SBTransactions
import SBTransactionsInterface
import SBSavingsGoals
import SBSavingsGoalsInterface
import SBWebClient
import SBWebClientInterface

// MARK: - IMPORTANT!! Please change this token to YOUR OWN token. Developer tokens expires after 24hrs. Refresh token was not implemented in this sample app.
private let token = "eyJhbGciOiJQUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_21Ty46jMBD8lRHn6RHGQAK3ue0P7Ac0djuxBmxkm8yOVvvvazCEEOVGVfWj2t38zbT3WZvhqEHSYD98QNdrc-nQfH0IO2TvmZ-6GKGk6gTmBEzlCOWZITRnIaFkecUa1Shk5xhMf8asZaeiqNiJNcV7pjEkouT5aSZQCDuZ8Mv2ktxvLdfaZ1ICZIU1lCUroDsjQcU5q3kpkXgZawf7RSZl5E3ddVQ2UHWooDxxBp1gFShGglTNm0o1MSOO9SkEeb_34YgIXdMVUBaCw5mLGiRXvDvlFZWqngcWdqT5UZJTuC5WweBArSOUb09C-BmfBC3JBK00uSPfax8OzAqkdNFkS1KHO0hKCCiuA90jd_ztdKA3nMLVOu3jykAbqW9aTtin4A57NGK1JtBJENYEZ_vUaGZWzRql3YBBWwNWgZqMXA2IyQc7bHPQgHrNHtBIDNRK6in62OASNlDAiLAVEc7ihpfMEX-INimBtUgCexDoAS9rzaTtnxAcGo9i9nynobciTr_XTgTY-Rme2TXLWaX7rVXqfaCWKBfPSo_hAPxRSvvweIur8HCxu48Dt4564JY6j0waTsVnf1FiF1_U2sVUVFxJTj1JiGPvZ-QphDjgNK5wxO1M4v8frygek3Xyof2R3foe2Rf5YL_NnQ80GwDhb8_UKFWiHne6rOJ5ydm__1_G9bayBAAA.DzsV3YAX2Snp2Es3TMjEVheGxuGCksNWYOYfUGmXKUrrYS-XuoVrLmOur1Jw8RR5d6x-poDZ2keKo-BUCCSkmLQdBmgKdbQj58F40M9wx-d_vQZ4R8l47FCFEIYkDvquWHiW-qdZnevyOYAwreB4sFf-xMnmBn7zbb7fzM1F6koox6zIua3UCkXm79CofxaO97q73u0wndUmi4bZCNCcW75zEgmaY66EcC8kkvKe4TJGOxM4PYbxW7PfcrwOHip6FIa5U6uLBo92pCP_7DyOoDOZPPk6yJwFJp2ZBDb2Ko3HnSiZZwTs1AdgkPo8MsBxv8Lvra_wH1U70Qg2aLI8x1LbibXUgd8El_5c8tYstN6zyzork0BND65P1dIozoHhpnuxv5zLm5QEox24QfMpqvD0gqpJYPa0GD-WLBMidEhTCp17Espa3_OBM-tKZ6aQNaeYjhcio0s_SdAf7fvG4CqszbEiSmz_GxO0GhuE_n52gnKgCaVZ0onOEoDMz34SWp05nSSwKwd0g1W5WCXDiNnwc-aXoga_kFcPuc1eHGoXaAGUoEUNqivwzbOgWGmwdteIrexVxEi8QrHLgEaxN4EG6dT2br9Os4Vd3ssXM7J4Uj8YrHOKQue_ZRTKnEm08gRWL9gbIsmwdSaVK6ZwRH4_PcgO8AinaZns6YEEZLc"

enum AppDependencyConfig {
    static func configure() {
        // Register accounts module gateway
        let accountGatewayClosure: () -> SBAccountInterface = { AccountModuleGateway() }
        DC.shared.register(dependency: .closure(accountGatewayClosure), for: SBAccountInterface.self)
        
        // Register transactions module gateway
        let transactionsGatewayClosure: () -> SBTransactionsInterface = { TransactionsModuleGateway() }
        DC.shared.register(dependency: .closure(transactionsGatewayClosure), for: SBTransactionsInterface.self)
        
        // Register savings goals module gateway
        let savingsGoalsGatewayClosure: () -> SBSavingsGoalsInterface = { SavingsGoalsModuleGateway() }
        DC.shared.register(dependency: .closure(savingsGoalsGatewayClosure), for: SBSavingsGoalsInterface.self)
        
        // Register web client
        let webClient = SBWebClient.shared
        webClient.setToken(token: token)
        DC.shared.register(dependency: .singleInstance(webClient), for: SBWebClientInterface.self)
    }
}
