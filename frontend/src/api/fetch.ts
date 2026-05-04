const defaultUrl = "http://localhost:3000";

/**
 * Fetch data from the backend API. 
 * @param route The url string. 
 * @returns The response body or null. 
 */
export async function fetchData<T>(route: string): Promise<T | null> {
    try {
        const response = await fetch(defaultUrl + route);
        if (!response.ok) {
            console.log(`HTTP error: {response.status}`)
            return Promise.reject(new Error())
        }
        const body: T = await response.json();
        return body;
    } catch (error) {
        console.error("fetch failed:", error);
        return null;
    }
}