describe ("Product Details Page", () => {
  beforeEach(() => {
    cy.visit("http://localhost:3000");
  });
  
  it("should redirect to product page after clicking on a product", () => {
    cy.get(".products article").first().click();
    cy.url().should("include", "/product/");
  });
});