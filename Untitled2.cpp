#include <iostream> //전처리기 :입출력 헤더파일 
#include <string>
#include <time.h>
#include <stdlib.h>
using namespace std; //cin. cout, endl...


int main(){
	string code1;
	string code2;
	int hamming=0;
	int cnt = 0;
	int e = 0;
	
	cout<<"첫번째 code: "<<endl;
	getline(cin,code1);

	cout<<"두번째 code: "<<endl;
	getline(cin,code2);
	
		
	
	while(1){
		if(code1[cnt] == '\0'){
		break;}
		if(code1.length()!=code2.length()){
			cout<<"X";
			break;
		}
		else{
			if(code1[cnt] != code2[cnt]){
				hamming++;
		}
		cnt++;
	}

	cout<<endl<<"해밍코드 거리: "<<hamming<<endl; 
	return 0;
}
