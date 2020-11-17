import '@stripe/stripe-js';

const button = document.getElementById("stripe")
const id = location.pathname.split("/")[2]
button.addEventListener("click", (e) => {
  fetch(`/payments?id=${id}`, {
    method: "POST",
    headers: {
      'Content-Type': 'application/json'
    }
  })
  .then((res) => {
    return res.json()
  })
  .then((data) => {
    const stripe = Stripe("pk_test_51HnvdhIyNUOg2LYjQHTncc2Mn2SJuPfDyAMRJdl7pDyjlk6o7zkY2IHxIBWVSz4dIsfCz2PK3obqRnka1OPXjHGP00qzj48vzP");
    stripe.redirectToCheckout({
      sessionId: data.id
    })
  })
  .catch((err) => {
    console.log(err.message)
  })
})