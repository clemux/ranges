class Combo {
    constructor(left, right, isSuited, isSelected) {
        this.left = left
        this.right = right
        this.isSuited = isSuited
        this.isSelected = isSelected
        this.isPair = this.left === this.right
        this.nbCards = this.getNbCards()
    }
    toString() {
        return this.left + this.right + (this.isPair ? "" : this.isSuited ? "s" : "o")
    }

    getNbCards() {
        if (this.isPair) return 6
        if (this.isSuited) return 4
        return 12
    }
}

function combos() {
    const cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
    let combos = [];
    cards.forEach(function callback(card_1, index) {
        cards.slice(0, index).forEach(function (card_2) {
            const combo = new Combo (
                card_2,
                cards[index],
                false,
                false
        )
            combos.push(combo)
        });
        cards.slice(index).forEach(function (card_2) {
            const left = cards[index]
            const right = card_2
            const isSuited = (left !== right)
            var combo = new Combo (
                left,
                right,
                isSuited,
                left === right && index < 3
            )
            combos.push(combo)
        });
    });
    return combos;
}


function parseCombo(comboString) {
    const split = comboString.split('')
    return {
        left: split[0],
        right: split[1],
        isSuited: (split.length !== 2 && split[2] === 's')
    }

}

function findCombo(combos, comboString) {
    const parsed = parseCombo(comboString)
    for (let i = 0; i < combos.count; i++) {
        const combo = combos.get(i)
        if (combo.left === parsed.left && combo.right === parsed.right && combo.isSuited === parsed.isSuited) {
            return combo
        }
    }
}
