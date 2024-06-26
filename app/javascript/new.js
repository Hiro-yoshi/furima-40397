document.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById('item-price');
  const taxPriceDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  priceInput.addEventListener('input', () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1); // 販売手数料は10%
    const profit = Math.floor(inputValue - tax); // 販売利益は価格から手数料を引いた額

    taxPriceDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  });
});
