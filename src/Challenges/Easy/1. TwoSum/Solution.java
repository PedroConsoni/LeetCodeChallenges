class Solution {
    public int[] twoSum(int[] nums, int target) {
        for (int i = 0; i < nums.length; i++) {           // Scroll through each number
            for (int j = i + 1; j < nums.length; j++) {   // Compare with all numbers in front
                if (nums[i] + nums[j] == target) {        // If the sum hits the target
                    return new int[] {i, j};              // returns both indexes
                }
            }
        }
        return new int[] {0, 0};                          // returns a default value
    }
}
