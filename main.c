#include <stdio.h>

int counter(int number){
    if(number == 0) return 1;
    int count = 0;
    while(number != 0){
        count += 1;
        number /= 10;
    }
    return count;
}

void additionalDigits(int a, int b, int countA, int countB){
    int add = 0, digitA, digitB, digitSum, arrLenght = countA;
    if(countA == countB)
        arrLenght+=1;
    char charArr[arrLenght];

    for(int i = 0; i < countA; i++){
        digitA=a%10;
        digitB=b%10;
        digitSum=digitA+digitB+add;
        if(digitSum >= 10) {
            charArr[arrLenght-i-1] = '1';
            add = 1;
        } else {
            charArr[arrLenght-i-1] = ' ';
            add = 0;
        }
        a/=10;
        b/=10;
    }
    if(countA<arrLenght)
        charArr[0]=' ';
    printf("%s\n", charArr);
}

void firstNumber(int number, int countA, int countB){
    if(countA > countB)
        printf(" %d", number);
    else
        printf("  %d", number);
}

void secondNumber(int number, int countA, int countB){
    printf("\n+ ");
    int i = countA-countB-1;
    while(i > 0){
        printf(" ");
        i--;
    }
    printf("%d\n", number);
}

void graphicLine(int countA, int countB){
    if(countA==countB)
        countA+=2;
    else
        countA++;

    for(int i = 0; i < countA; i++){
        printf("-");
    }
    printf("\n");
}

void resultNumber(int result, int countA, int countB){
    int countRes=counter(result);
    if(countRes > countA && countA == countB)
        printf(" %d", result);
    else if(countA == countB)
        printf("  %d", result);
    else if(countRes > countA)
        printf("%d", result);
    else
        printf(" %d", result);
}

int main() {
    printf("Podaj dwie liczby...\n");
    int val1, val2, a, b, result;

    printf("Pierwsza liczba: ");
    scanf("%d", &val1);
    printf("Druga liczba: ");
    scanf("%d", &val2);

    result=val1+val2;
    if(val1>=val2){
        a=val1;
        b=val2;
    } else {
        a=val2;
        b=val1;
    }

    int countA = counter(a), countB = counter(b);

    additionalDigits(a, b, countA, countB);
    firstNumber(a, countA, countB);
    secondNumber(b, countA, countB);
    graphicLine(countA, countB);
    resultNumber(result, countA, countB);
    return 0;
}
