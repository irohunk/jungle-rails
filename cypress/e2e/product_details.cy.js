describe('Product Details', () => {
  // it('should visit the home page', () => {
  //   // Visit the home page
  //   cy.visit('/');

  //   // Check if the page contains the title or element that confirms the home page is loaded
  //   cy.contains('Jungle'); // Adjust this to match the actual text or element on your homepage
  // });

  // it("There is products on the page", () => {
  //   cy.visit("/");
  //   cy.get(".products article").should("be.visible");
  // });

  // it("There is 2 products on the page", () => {
  //   cy.visit("/");
  //   cy.get(".products article").should("have.length", 2);
  // });

  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('/');
  });

  it('should navigate to the product detail page when a product is clicked', () => {
    // Find the first product on the page and click on its link
    cy.get('.products article').first().find('a').click();

    // Assert that the URL includes /products/ and that it navigated to a product detail page
    cy.url().should('include', '/products/');

    // Assert that the product detail page contains the product details
    cy.get('.product-detail').should('be.visible');
  });
});
