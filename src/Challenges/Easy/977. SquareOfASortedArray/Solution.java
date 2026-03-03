class Solution {
    public int[] sortedSquares(int[] nums) {
        int[] result = new int[nums.length];               // Create a new array of the same size as nums
        for (int i = 0; i < nums.length; i++) {
            result[i] = nums[i] * nums[i];                 // Iterates through the original array and at each position, stores the square of the number in the new array
        }
        Arrays.sort(result);                               // Use the .sort() method to sort the numbers in ascending order
        return result;                                     // Returns the array with the squared and ordered numbers
    }
}