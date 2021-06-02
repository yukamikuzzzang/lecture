#include <iostream>
#include <ctime>
#include <cstdlib>
 
using namespace std;
/*
int big(int a, int b){
	if(a>b) return a;
	else return b;	
}

int big(int a[], int size){
	int res = a[0];
	for(int i=1;i<size;i++){
		if(res<a[i]) res = a[i];
	}
	return res;
}

int small(int a, int b){
	if(a<b) return a;
	else return b;
}

int small(int a[], int size) {
	int res = a[0];
	for(int i=1;i<size;i++){
		if(res>a[i]) res = a[i];
	}
	return res;
}

int main(){
	int ar[] = {1,8,-3,4,6,7,8,6,4,56,4};
	cout<<"최대값:"<<big(2,3)<<endl;
	cout<<"최대값:"<<big(ar,(sizeof(ar)/sizeof(ar[0])))<<endl;
	cout<<"최소값:"<<small(56,23)<<endl;
	cout<<"최소값:"<<small(ar,(sizeof(ar)/sizeof(ar[0])))<<endl;
	return 0;	
	
	cout<<sizeof(ar)<<endl;
}
*/
/*
class MyVector{
	int *p;
	int size;
	public:
		MyVector(int n = 100) {
		p = new int[n];
		size = n;}
};

int main() {
	MyVector *v1, *v2;
	v1 = new MyVector();
	v2 = new MyVector(1024);
	
	delete v1;
	delete v2;	//알아서 가져감. 객체 생성시 필수로 써야.. 
}
*/
/*
void lotto(int y[], string s, int size = 6){
	int r = rand()%46+1;
	
	if(s == "중복가능로또"){
		for(int i=0;i<size;i++){
			y[i] = rand()%45+1;
			cout<<y[i]<<endl;
		}
		cout<<endl;
	}else{
		//y[0]=rnad()%45+1;
		for(int i=0;i<size;i++){
			y[i] = rand()%45+1;
			for(int j=0;j<i;j++) {
				if(y[i]==y[j]){
					i--;
					break;	
				}
			}
			cout<<y[i]<<endl;
		}	
	}
	cout<<endl;	
}
int main(){
	srand(time(NULL));
//	int r = rand()%100+1; //1~100 사이의 임의의 수 
//	//cout<<r<<endl;
	
	int x[6];
	lotto(x,"중복가능로또");//1~46사이 중 6개의 임의의 수 출력 
	lotto(x,"중복불가능로또",sizeof(x)/sizeof(x[0])); 
	return 0;
}*/
/*문제 Up & Down 게임- static*/
class Person{
private:
	string name;
public:
	Person(string a){
		name = a;
	
	}
	string getName(){
		return name;
	}
}; 
class UpDownGame{
	public:
		//int r = rand()%100+1;
		static int top; //top=99
		static int down; //down=0
		static void upDownRun(){
			Person p[2] = {Person("김성진"), Person("김희익")};
			srand(time(NULL));
			int i = 0;
			int key = 0;
			int r = rand()%100+1;
			
			cout<<"Up & Down 게임을 시작합니다."<<endl;
			cout<<"답은"<<down<<"과 "<<top<<"사이에 있습니다."<<endl<<endl; 
			
			while(true){
				i = i%2;
				cout<< p[i].getName() <<">>";
				cin>>key;
				
				if(key > r){
					UpDownGame::top = key;
					cout<<"답은 "<<UpDownGame::down<<"와 "<<UpDownGame::top<<"사이에 있습니다."<<endl;
				}
				else if (key < r){
					UpDownGame::down = key;
					cout<<"답은 "<<UpDownGame::down<<"와 "<<UpDownGame::top<<"사이에 있습니다."<<endl;
				}
				else if(key == r){
					cout<<p[i].getName()<<"이 이겼습니다!!"<<endl;
					break;
				}
				i++;
			}
	}
		
		
};
int UpDownGame::top = 99;
int UpDownGame::down = 0;


int main(){
	//rand()%45+1
	UpDownGame::upDownRun();
	return 0;
}

