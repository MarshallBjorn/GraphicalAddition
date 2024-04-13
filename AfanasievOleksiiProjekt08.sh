#!bin/bash

#Funckja zlicza ilość cyfr liczby.
counter(){
	value=$1
	counter=0
	if [ $value -eq 0 ];then
		counter=1
	fi
	while [ $value -gt 0 ]
	do
		((counter++))
		value=$((value/10))
	done

	echo $counter
}


#Funkcja sprawdza któraz podanych liczb jest większa i przypisuje ją do a i b.
greaterNumber() {
	if  [ $1 -le $2 ]; then
		a=$2
		b=$1
	else
		a=$1
		b=$2
	fi
}


#Funkcja co odpowiada za narysowanie linii po podaniu liczb
graphicFunc() {
	str=""
	value=$(($1+1))

	if [ $1 -eq $2 ]; then
		value=$((value+1))
	fi
	for i in $(seq 1 $value);
	do
		str+="-"
	done
	echo $str
}

#Funkcja co wizualizuje część pisemnego dodawania gdzie po dodaniu dwóch cyfr ich suma wynosi >= 10
additionalDigits() {
	copyA=$1
	copyB=$2
	aditional=0
	str=""

	for i in $(seq 1 $counterA)
	do
		digitA=$(($copyA%10))
		digitB=$(($copyB%10))
		digitSum=$(($digitA+$digitB+$aditional))

		if [ $copyB -gt 0 ] && [ $digitSum -ge 10 ]; then
			aditional=1
			temp="1"
			str=$temp$str
		else
			aditional=0
			temp="0"
			str=$temp$str
		fi
		copyA=$((copyA/10))
		copyB=$((copyB/10))
	done
	if [ $counterA = $counterB ];then
		temp="0"
		str=$temp$str
	fi
	echo $str | sed 's/0/ /g'
}


#Zczytanie od użytkownika dwóch liczb
echo "Podaj dwie liczby naturalne, mniejsze od 2^63-1"
read val1
read val2
re='^[0-9]+$'

if ! [[ $val1 =~ $re ]] || ! [[ $val2 =~ $re ]]; then
	echo "Błąd no.1: Podany został tekst zamiast liczby"
	exit 1
fi
if [ $val1 -lt 0 ] || [ $val2 -lt 0 ]; then
	echo "Błąd no.2: Liczba jest mniejsza od zera"
	exit 1
fi


#Uzyskanie wyniku oraz tworzenie zmiennych a i b, gdzie a >= b
result=$((val1+val2))
greaterNumber $val1 $val2


#Obliczenie ilości cyfr i przypisanie ich do zmiennych.
counterA=$(counter $a)
counterB=$(counter $b)

additionalDigits $a $b

#Wyświetlenie pierwszej liczby.
if [ $counterA -gt $counterB ];
then
	echo " $a"
else
	echo "  $a"
fi


#Wyświetlenie drugiej liczby.
str="+ "
value=$(($counterA-$counterB-1))
while [ $value -gt 0 ]
do
	str+="-"
	((value--))
done
str+=$b
echo $str | sed 's/-/ /g'


#Wyświetlenie linii.
graphicFunc $counterA $counterB


#Wyświetlenie wyniku.
counterResult=$(counter $result)
if [ $counterResult -gt $counterA ] && [ $counterA -eq $counterB ]; then
	echo " $result"
elif [ $counterA -eq $counterB ]; then
	echo "  $result"
elif [ $counterResult -gt $counterA ]; then
	echo $result
else
	echo " $result"
fi
