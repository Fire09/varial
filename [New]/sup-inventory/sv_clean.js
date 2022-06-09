setInterval(() => {
    console.log("TEST HERE")
    db(`DELETE FROM user_inventory2 WHERE name like '%Drop-%'`);
    db(`DELETE FROM user_inventory2 WHERE name='Stolen-Goods-1' and item_id NOT IN (${stolenGoodsString})`);
}, 10 * 60 * 1000);