function combos() {
    var cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
    var combos = [];
    cards.forEach(function callback(card_1, index) {
        cards.slice(0, index).forEach(function (card_2) {
            combos.push(card_2 + cards[index]);
        });
        cards.slice(index).forEach(function (card_2) {
            combos.push(cards[index] + card_2);
        });
    });
    return combos;
}
