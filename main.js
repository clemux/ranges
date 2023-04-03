function combos() {
    const cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"];
    let combos = [];
    cards.forEach(function callback(card_1, index) {
        cards.slice(0, index).forEach(function (card_2) {
            const combo = {
                left: card_2,
                right: cards[index],
                isSuited: false
            }
            combos.push(combo)
        });
        cards.slice(index).forEach(function (card_2) {
            const left = cards[index]
            const right = card_2
            const isSuited = (left !== right)
            combos.push({
                left: left,
                right: right,
                isSuited: isSuited
            });
        });
    });
    return combos;
}

function selectPairs(start) {
    const pairs = ["JJ", "QQ", "KK", "AA"]
    return pairs.slice(pairs.indexOf(start))
}

function getCombos() {
    const s = new Set([1]);
    return s
}


function getId() {
    return "aks"
}

function parseCombo(comboString) {
    const split = comboString.split('')
    return {
        left: split[0],
        right: split[1],
        isSuited: (split.length !== 2 && split[2] === 's')
    }

}

function getCombo(combos, comboString) {
    const parsed = parseCombo(comboString)

    return combos.findIndex((combo) =>
        (combo.left === parsed.left && combo.right === parsed.right && combo.isSuited === parsed.isSuited)
    )
}