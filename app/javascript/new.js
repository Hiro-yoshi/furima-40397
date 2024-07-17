const setupPriceCalculation = () => {
  const priceInput = document.getElementById('item-price');
  const taxPriceDom = document.getElementById('add-tax-price');
  const profitDom = document.getElementById('profit');

  const calculatePrice = () => {
    const inputValue = priceInput.value;
    const tax = Math.floor(inputValue * 0.1);
    const profit = Math.floor(inputValue - tax);

    taxPriceDom.innerHTML = tax;
    profitDom.innerHTML = profit;
  };

  if (priceInput) {
    if (priceInput.value) {
      calculatePrice();
    }
    priceInput.addEventListener('input', calculatePrice);
  }
};

document.addEventListener("turbo:load", setupPriceCalculation);
document.addEventListener("turbo:render", setupPriceCalculation);
