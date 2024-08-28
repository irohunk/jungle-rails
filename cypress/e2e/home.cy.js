describe('Home Page', () => {
  it('should visit the home page', () => {
    // Visit the home page
    cy.visit('/');

    // Check if the page contains the title or element that confirms the home page is loaded
    cy.contains('Jungle'); // Adjust this to match the actual text or element on your homepage
  });

  it("There is products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.visit("/");
    cy.get(".products article").should("have.length", 2);
  });
});
