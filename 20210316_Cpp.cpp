//��ü�������α׷���I :C++
#include <iostream> //��ó���� :����� ������� 
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
	
	cout<<"ù��° code: "<<endl;
	getline(cin,code1);

	cout<<"�ι�° code: "<<endl;
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

	cout<<endl<<"�ع��ڵ� �Ÿ�: "<<hamming<<endl; 
	
	
	
	*/
	
/*
	const int num = 5;
	int score[num];
	int cnt = 0;
	int sum = 0;
	string name = "";
	
	cout<<"����������? ";
	getline(cin,name);
	while(cnt< 5){
		cout<<cnt+1<<"�� �л�����? ";
		cin>>score[cnt];
		
		if(score[cnt]>=0 && score[cnt]<=100){
		
		sum+=score[cnt];
		cout<<endl<<sum<<endl;
		cnt++;
		}else{
			cout<<"�ٽ��Է����ּ���";
		}
		
	}
		float avg=float(sum)/(cnt);
		cout<<"��= "<<sum<<" ���= "<<avg;
*/
/*
	char ch;
	int cntA= 0;
	int cntB= 0;
	cout<<"����?";
	while(cin>>ch){
		cout<<"����?";
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
	cout<<"������ ��: "<<cntA; 
	cout<<"������ ��: "<<cntB;
*/

/*����1	
	srand(time(NULL));
	int cnt=0;
	while(true){
		srand(time(NULL));
		int num1 = rand()%10+1;
		cout<<"ù ��°��: "<<num1;
		int num2 = rand()%10+1;
		cout<<"�� ��°��: "<<num2;
		cout<<"����?";
		int anw;
		cin>>anw;
				
		if((num1+num2) == anw){
			cout<<" ����...��";
			break;
		}
		cout<<"Ʋ�Ƚ��ϴ�.";
		cnt++;
	}
	cout<<cnt<<" �� Ʋ�Ƚ��ϴ�.";
*/	
//	char name[11];
//	cin >> name;	//���������, ��������� �� ���ڿ��� ���ڴ�. 
//	cout<<"�̸��� "<<name<<"�Դϴ�."<<endl; 
//	cin.ignore();
//	cout <<"�ּҸ� �Է��ϼ���>> ";
//	char address[100];
//	cin.getline(address,100, '\n'); //character
//	cout<<"�ּҴ� "<<address<<"�Դϴ�."<<endl;
//	cout<<address[3]<<endl<<sizeof(address)<<endl; 
//	cin.ignore();//���� �����
//	string s,s2,s3="Apple", s4("banana");
//	cin >> s;	//��������� 
//	cout<<"s = "<<s<<endl;
//	cin.ignore(); 
//	getline(cin,s2);//��������,string 
//		cout<<"s2 = "<<s2<<",3��"<<s2[3]<<endl;
//	return 0; 
//


/*
int x=100;//�������� 
void show(); //�Լ����� 

cout<<"Hello"<<endl;
show(5); 
*/
	return 0;//���� :F11 
}
/*
void show(int a) //�����Լ�
{
	cout<<"�� �Լ�"<<endl;	
}
*/

//C++�Ϻ��� ĸ��ȭ�� ���� ����.
 
 
