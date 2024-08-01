#! /bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
  
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  CONDITION="elements.atomic_number = $1"
else
  CONDITION="elements.symbol = '$1' OR elements.name = '$1'"
fi
INFO=$($PSQL "SELECT atomic_number, name, symbol, atomic_mass, melting_point_celsius, boiling_point_celsius FROM properties INNER JOIN elements using(atomic_number) WHERE $CONDITION ") 
#echo "$INFO"
TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE $CONDITION")
if [[ -z $INFO ]]; then
  echo "I could not find that element in the database."
else
  echo "$INFO" | while read ATOMIC_NUMBER BAR NAME BAR SYMBOL BAR ATOMIC_MASS BAR MELTING BAR BOILING  
    
    do
            echo  "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a$TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

    done 
fi



#once again
#maybe this time
#hope
#hoooope
#the light at the end of the tunnel
#feat
#last commit
#one more
