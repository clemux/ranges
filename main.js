function combos() {
    var cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
    var combos = [];
    cards.forEach(function callback(card_1, index) {
        cards.slice(0, index).forEach(function (card_2) {
            const leftCard = card_2
            const rightCard = cards[index]
            const isSuited = false
            combos.push([leftCard, rightCard, isSuited]);
        });
        cards.slice(index).forEach(function (card_2) {
            combos.push([cards[index], card_2, true]);
        });
    });
    return combos;
}
