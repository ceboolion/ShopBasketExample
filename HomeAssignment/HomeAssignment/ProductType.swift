import UIKit

enum ProductType: CaseIterable {
    case milk
    case egg
    case banana
    case potato
    case none
    
    var image: ImageResource {
        switch self {
        case .milk:
            return .milk
        case .egg:
            return .eggs
        case .banana:
            return .bananas
        case .potato:
            return .potatos
        case .none:
            return .placeholder
        }
    }
    
    var productTitle: String {
        switch self {
        case .milk:
            return "Najlepsze mleko na świecie"
        case .egg:
            return "Najlepsze jajka na świecie"
        case .banana:
            return "Najlepsze banany na świecie"
        case .potato:
            return "Najlepsze ziemniaki na świecie"
        case .none:
            return " - "
        }
    }
    
    var shortTitle: String {
        switch self {
        case .milk:
            return "MLEKO"
        case .egg:
            return "JAJKA"
        case .banana:
            return "BANANY"
        case .potato:
            return "ZIEMNIAKI"
        case .none:
            return " - "
        }
    }
    
    var description: String {
        switch self {
        case .milk:
            "Mleko Wiejskie od krów wypasanych na łąkach Kurpi Zielonych wyróżnia się naturalnym smakiem i zapachem. Spełnia najwyższe standardy jakości w Polsce i zawiera bogactwo składników odżywczych: białek serwatkowych i witamin A, D i E. Aby mleko łatwo było ze sobą zabrać, wlaliśmy je do wygodnej butelki z uchwytem. Doskonałe do picia oraz jako niezastąpiony składnik owsianek, koktajli, naleśników czy deserów."
        case .egg:
            "Farmio Jaja z wolnego wybiegu od kur karmionych paszą wolną od GMO M 12 sztuk"
        case .banana:
            "Dzięki dużej zawartości łatwo przyswajalnych węglowodanów i składników mineralnych (potas, fosfor, magnez) zaliczany jest do owoców o wysokiej wartości odżywczej, a także energetycznej (100 g miąższu to 81 kcal). Biologicznie czynne związki działają uspokajająco i leczniczo na przewód pokarmowy. Banany powinni włączyć do diety ludzie cierpiący na anemię, celiakię, obrzęki (duża ilość potasu działa odwadniająco)"
        case .potato:
            "Ziemniak to roślina z rodziny psiankowatych. Dla wielu z nas jest podstawą obiadu, jednak na polskich stołach obecny jest dopiero od XVII wieku. W polskiej kuchni trudno wyobrazić sobie obiad bez ziemniaków. A przecież ziemniaki są obecne na naszych stołach stosunkowo od niedawna. Wydają się jednak nieodzownym składnikiem naszej diety. Tak często jemy kartofle, że zupełnie nie zastanawiamy się, ile mają zalet. Gotowane, pieczone, smażone, w formie purée, frytek albo chipsów – każdy z nas ma swój ulubiony wariant ziemniaków. Bez wątpienia to jedne z najbardziej popularnych produktów na naszych stołach. Ziemniaki regulują prawidłowe trawienie, a szczególnie jelita i przewód pokarmowy. Ziemniaki są bogate w liczne witaminy oraz mikroelementy."
        case .none:
            ""
        }
    }
    
}
