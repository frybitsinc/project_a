//Maximum Contiguous Subsequence Problem
//Programming Report #1
//2016-04-06
//Method1 : Iteration
//Method2 : Divide and conquer
//Method3 : Dynamic(?) Programming(doesn't seem dynamic tho..)
#define _CRT_SECURE_NO_DEPRECATE
#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <math.h>
#include <time.h>
#pragma comment(lib, "winmm.lib")
#define FILE_NAME "p1data5.txt"
int* n_arr;
int n;

struct Result {
	int index_i;
	int index_j;
	int largest_sum;
};

struct Result result1;
struct Result result2;
struct Result result3;

int Method1(int* n_arr, int l, int h) {
	int i, j, temp_sum=0;
	int index_i=0, index_j=0, largest_sum = 0;
	for (i = l; i <= h; i++) {
		temp_sum = n_arr[i];
		for (j = i+1; j <= h; j++) {
			temp_sum += n_arr[j];
			if (temp_sum > largest_sum) {
				largest_sum = temp_sum;
				index_i = i;
				index_j = j;
			}
		}
	}
	result1.largest_sum = largest_sum;
	result1.index_i = index_i;
	result1.index_j = index_j;

	return 0;
}

int Method2(int* n_arr, int l, int h) {
	int l_temp_i=0, l_temp_j=0, h_temp_i=0, h_temp_j=0, index_i=0, index_j=0, largest_sum = 0;
	int i, temp_sum=0, l_sum, h_sum, l_max, h_max;
	if (l == h)
		return n_arr[l];
	int m = (l + h) / 2;
	l_sum = Method2(n_arr, l, m);
	h_sum = Method2(n_arr, m + 1, h);
	l_max = n_arr[m];
	h_max = n_arr[m + 1];
	for (i = m; i >= l; i--) {
		temp_sum += n_arr[i];
		if (temp_sum > l_max) { 
			l_max = temp_sum;
			l_temp_i = i; 
			l_temp_j = m;
		}
	}
	temp_sum = 0;
	for (i = m + 1; i <= h; i++) {
		temp_sum += n_arr[i];
		if (temp_sum > h_max) { 
			h_max = temp_sum;
			h_temp_i = m + 1;
			h_temp_j = i;
		}
	}
	if (l_sum >= h_sum) {
		largest_sum = l_sum;
		index_i = l_temp_i;
		index_j = l_temp_j;
	}
	else {
		largest_sum = l_sum;
		index_i = h_temp_i;
		index_j = h_temp_j;
	}
	if ((l_max + h_max) > largest_sum) {
		largest_sum = (l_max + h_max);
		index_i = l_temp_i;
		index_j = h_temp_j;
	}

	result2.largest_sum = largest_sum;
	result2.index_i = index_i;
	result2.index_j = index_j;
	
	return 0;
}

int Method3(int* n_arr, int l, int h) {

	int i, j, temp_sum = 0;
	int index_i=0, index_j=0, largest_sum = 0;

	largest_sum = n_arr[0];
	for (i = 0; i <= h; i++) {
		temp_sum += n_arr[i];
		if (temp_sum < 0) {
			temp_sum = 0;
			index_i = i + 1;
		}
		else if (temp_sum == 0) {
			index_i = i + 1;
		}
		if (temp_sum > largest_sum) {
			if (temp_sum == 0) {
				if (largest_sum < n_arr[i]) {
					largest_sum = n_arr[i];
					index_i = index_j = i;
				}
			}
			else {
				largest_sum = temp_sum;
				result3.index_j = i;
				result3.index_i = index_i;
			}
		}
	}
	if (largest_sum < 0) { result3.index_i = index_j; }
	result3.largest_sum = largest_sum;
	return 0;
}

int main(){
	int i;
	int* ptr;
	FILE *fp;
	fp = fopen(FILE_NAME, "r");
	if (fp == NULL) {	//파일 존재여부 확인
		printf("ERROR : 파일이 존재하지 않습니다. ");
		return -1;
	}
	//원소의 개수 n
	fscanf(fp, "%d", &n);
	//n개의 원소값이 들어갈 배열 동적할당
	n_arr = (int*)malloc(sizeof(int)*n);
	memset(n_arr, 0, sizeof(int)*n); //n_arr 배열 초기화
	//n개의 원소값 배열에 입력받기
	for (i = 0; i < n; i++) {
		fscanf(fp, "%d", &n_arr[i]);
	}
	fclose(fp);
	ptr = &n_arr[0];
	printf("Input data %s:\n", FILE_NAME);

	//Method1
	//중첩반복문 이용
	DWORD dwStartTime = timeGetTime();	//실행시간측정 시작
	Method1(ptr, 0, n - 1);				//함수실행
	DWORD dwEndTime = timeGetTime();	//실행시간측정 종료
	printf("(Method 1)\n");
	printf("  The Maximum sum = %d, indices from %d to %d\n", result1.largest_sum, result1.index_i, result1.index_j);
	printf("  The execution time = %lu msec\n", (dwEndTime - dwStartTime));

	//Method2
	//분할정복방법 이용
	dwStartTime = timeGetTime();	//실행시간측정 시작
	Method2(ptr, 0, n - 1);			//함수실행
	dwEndTime = timeGetTime();		//실행시간측정 종료
	printf("(Method 2)\n");
	printf("  The Maximum sum = %d, indices from %d to %d\n", result2.largest_sum, result2.index_i, result2.index_j);
	printf("  The execution time = %lu msec\n", (dwEndTime - dwStartTime));

	//Method3
	//동적계획법 이용
	dwStartTime = timeGetTime();	//실행시간측정 시작
	Method3(ptr, 0, n - 1);			//함수실행
	dwEndTime = timeGetTime();		//실행시간측정 종료
	printf("(Method 3)\n");
	printf("  The Maximum sum = %d, indices from %d to %d\n", result3.largest_sum, result3.index_i, result3.index_j);
	printf("  The execution time = %lu msec\n", (dwEndTime - dwStartTime));

	return 0;
}
