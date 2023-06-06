describe ("Add to Cart", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000");
  });

  it("should increase cart count by one when user click 'Add to Cart' button", () => {
    cy.get(".btn")
    .first()
    .contains("Add")
    .scrollIntoView()
    .click({ force: true });

    cy.get(".nav-link").contains("Cart").should("contain", "Cart (1)");
  });
  });
