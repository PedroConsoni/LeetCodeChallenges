class Solution {
    public boolean isPalindrome(int x) {
        int comparator = x;                         // Makes a copy of x
        int reverse = 0;                            // Accumulator where the integer will be constructed
        int rest;                                   // Rest of the divisions that will be obtained through operations with %

        while(comparator > 0) {
            rest = comparator % 10;                // Get the remainder of the number when divided by 10
            reverse = (reverse * 10) + rest;       // Multiply by 10 to move one decimal place and add the remainder
            comparator = comparator / 10;          // Remove the last digit from the comparator
        }
        if (reverse == x) {
            return true;
        } else {
            return false;
        }
    }
}
