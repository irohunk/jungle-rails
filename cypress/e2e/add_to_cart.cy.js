describe('Add to Cart', () => {
  beforeEach(() => {
    // Visit the home page before each test
    cy.visit('/');
  });

  it('should increase the cart count by one when a product is added to the cart', () => {
    // Check the initial cart count (assuming it's 0 or another known value)
    cy.get('a[href="/cart"]').should('contain', 'My Cart (0)');

    // Find the first product on the page and click on 'Add to Cart' button
    cy.get('.products article').first().find('button').click({ force: true });

    // Assert that the cart count has increased by 1
    cy.get('a[href="/cart"]').should('contain', 'My Cart (1)');
  });
});
