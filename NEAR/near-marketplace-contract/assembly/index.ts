import { PersistentUnorderedMap } from "near-sdk-as";

// Create a PersistentUnorderedMap instance to store our products
export const products = new PersistentUnorderedMap<string, string>("PRODUCTS");

// Function to add a new product to the "products" map
export function setProduct(id: string, productName: string): void {
    products.set(id, productName);
}