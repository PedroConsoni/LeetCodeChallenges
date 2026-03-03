class Solution {
    public int singleNumber(int[] nums) {
        int result = 0;                 // Initializes the variable that stores the results of the XOR operation of all the numbers in the Array

        for(int num : nums) {
            result ^= num;              // Applies the XOR operation between the current value of result and num
        }
        return result;                  //  Returns the number that appeared in the Array only once
    }
}
