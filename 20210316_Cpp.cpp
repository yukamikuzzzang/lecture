//객체지향프로그래밍I :C++
#include <iostream> //전처리기 :입출력 헤더파일 
#include <string>
#include <time.h>
#include <stdlib.h>
using namespace std; //cin. cout, endl...


int main(){
	
	/*
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
		try{
			if(code1[cnt] == '\0') throw e;
			if(code2[cnt] == '\0') throw e;
			
			if(code1[cnt] != code2[cnt]){
				hamming++;
			}else{
				cnt++;
			}
		}
		catch(int expn){
		
		
			expn = 0;
			break;
		}		
	}

	cout<<endl<<"해밍코드 거리: "<<hamming<<endl; 
	
	
	
	*/
	
/*
	const int num = 5;
	int score[num];
	int cnt = 0;
	int sum = 0;
	string name = "";
	
	cout<<"지도교수명? ";
	getline(cin,name);
	while(cnt< 5){
		cout<<cnt+1<<"번 학생점수? ";
		cin>>score[cnt];
		
		if(score[cnt]>=0 && score[cnt]<=100){
		
		sum+=score[cnt];
		cout<<endl<<sum<<endl;
		cnt++;
		}else{
			cout<<"다시입력해주세요";
		}
		
	}
		float avg=float(sum)/(cnt);
		cout<<"합= "<<sum<<" 평균= "<<avg;
*/
/*
	char ch;
	int cntA= 0;
	int cntB= 0;
	cout<<"문자?";
	while(cin>>ch){
		cout<<"문자?";
		if(ch == 'a'){
			cntA++;
		}else if(ch == 'e'){
			cntA++;
		}else if(ch == 'i'){
			cntA++;
		}else if(ch == 'o'){
			cntA++;
		}else if(ch == 'u'){
			cntA++;
		}else{
			cntB++;
		}
	} 
	cout<<"모음의 수: "<<cntA; 
	cout<<"자음의 수: "<<cntB;
*/

/*문제1	
	srand(time(NULL));
	int cnt=0;
	while(true){
		srand(time(NULL));
		int num1 = rand()%10+1;
		cout<<"첫 번째수: "<<num1;
		int num2 = rand()%10+1;
		cout<<"두 번째수: "<<num2;
		cout<<"합은?";
		int anw;
		cin>>anw;
				
		if((num1+num2) == anw){
			cout<<" 정답...끝";
			break;
		}
		cout<<"틀렸습니다.";
		cnt++;
	}
	cout<<cnt<<" 번 틀렸습니다.";
*/	
//	char name[11];
//	cin >> name;	//공백미포함, 공백까지를 한 문자열로 보겠다. 
//	cout<<"이름은 "<<name<<"입니다."<<endl; 
//	cin.ignore();
//	cout <<"주소를 입력하세요>> ";
//	char address[100];
//	cin.getline(address,100, '\n'); //character
//	cout<<"주소는 "<<address<<"입니다."<<endl;
//	cout<<address[3]<<endl<<sizeof(address)<<endl; 
//	cin.ignore();//버퍼 지우기
//	string s,s2,s3="Apple", s4("banana");
//	cin >> s;	//공백미포함 
//	cout<<"s = "<<s<<endl;
//	cin.ignore(); 
//	getline(cin,s2);//공백포함,string 
//		cout<<"s2 = "<<s2<<",3번"<<s2[3]<<endl;
//	return 0; 
//


/*
int x=100;//전역변수 
void show(); //함수원형 

cout<<"Hello"<<endl;
show(5); 
*/
	return 0;//실행 :F11 
}
/*
void show(int a) //전역함수
{
	cout<<"쇼 함수"<<endl;	
}
*/

//C++완벽한 캡슐화가 되진 않음.
 
 
