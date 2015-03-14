//
//  main.cpp
//  SELab2_2_1
//
//  Created by Emre Ozan Alkan on 10/7/13.
//  Copyright (c) 2013 Emre Ozan Alkan. All rights reserved.
//

#include <iostream>

using namespace std;

void ExampleInputOutput(void);

int main(int argc, const char * argv[])
{
    ExampleInputOutput();
    
    return EXIT_SUCCESS;
}

/*
 * Function: ExampleInputOutput
 * -----------------------------
 * Showing usage of coun, cin and endl
 * Asks name and frist getting it with cin
 * Later asks name again and get that 
 * with getline() function/
 * *** However I had problem with using getline,
 * maybe because of XCode, I had to use
 * cin.clear() to clean my cin buff before
 * getting the input, otherwise it was
 * skipping the input.
 *
 * prints: the input as name
 *
 */
void ExampleInputOutput()
{
    string input;
    cout<<"Please enter your name"<<endl;
    cin>>input;
    cout<<"Your name is: "<<input<<endl;
    
    input.empty();
    
    cout<<"We are sorry, we lost your name, can you re enter ?"<<endl;
    
    cin.clear();
    cin.ignore(INT_MAX,'\n');
    getline(cin, input);
    
    cout<<"Thank you, we got your name as: "<<input<<endl;

}

