from audioop import reverse
from functools import reduce
from re import S


class Solution:
    def removePalindromeSub(self, s: str) -> int:
        return 1 if s[::-1] == s else 2


if __name__ == '__main__':

    print(Solution().removePalindromeSub("aba"))
