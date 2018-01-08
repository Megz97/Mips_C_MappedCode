#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
int size=14;
char mssg[]="Enter your Number of List : \n";
char EnterNumberMssg[]="-Enter Number: ";
char choiceMssg[]="\nEnter 1 to Enter new number or 2 for new List or other to Terminate :";
char numberMssg[]="\nEnter specific number for calc occurence : ";
char occurenceMssg[]="it's occurence number is : ";
char TerminatedMssg[]="\n The Program was Terminated";

void readList(float list[])
{
    char number[10];       //Numbers to store to List
    int iterator=0;
    int check;
    do
    {
        printf("%d",iterator);
        printf("%s",EnterNumberMssg);
        scanf("%s", number);
        list[iterator]=atof(number); //store Number To list
        iterator++;            //increment iterator
    }
    while( iterator <= size );  //if iterator <= size then out loop


    for(iterator=0; iterator<=size; iterator++)
    {
        printf("%f\n",list[iterator]);
    }
}


int getOccurence(float list[], float SpecificNumber)
{
    int iterator=0;
    int count=0;    //Count the occurence of SpecificNumber
    do
    {
        if(list[iterator]==SpecificNumber)  //if SpecificNumber in list then
            count++;       //increment count by 1

        iterator++;       //increment iterator by 1
    }
    while( iterator <= size ); //if iterator <= size then out loop

    return count; //return count to caller
}



int main()
{
    float SpecificNumber=0;  //intialize Number that user will enter
    char choiceNumber[10];      //choiceNumber for next operation
    float list[15];          //intialize list

newList:
    printf("%s",mssg);
    readList(list);    //send address of list to readList function
newNumber:
    printf("%s",numberMssg);
    scanf("%f",&SpecificNumber);  //get SpecificNumber from user

    int occurenceNumber=getOccurence(list,SpecificNumber); //send list and SpecificNumber to getOccurence Function

    printf("%s",occurenceMssg);
    printf("%d",occurenceNumber);  //print OccurenceNumber

newChoice:
    printf("%s",choiceMssg);
    scanf("%s",choiceNumber);    //get choiceNumber from user
    if(atoi(choiceNumber)==1)
        goto newNumber;        // goto NewNumber Label to get newNumber
    else if(atoi(choiceNumber)==2)
        goto newList;        // goto NewList Label to get newList

    else if(atoi(choiceNumber)==0)
        goto newChoice;        // goto NewList Label to get newList


    printf("%s",TerminatedMssg);
    return 0;
}
