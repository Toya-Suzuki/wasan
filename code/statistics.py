import sys
import os


def main():
    # 14883 all count
    All_14883 = 0
    # 14883 success
    success_14883 = 0

    with open("summaryFile.txt", "rt") as sumF:
        for x in sumF:
            y = x.strip()
            z = y.split(" ")
            All_14883 = All_14883 + int(z[1])
            success_14883 = success_14883 + int(z[2])

        print("Statistis")
        print(float(success_14883/All_14883*100))


if __name__ == "__main__":
    main()
