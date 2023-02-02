package com.myschool.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.myschool.VO.CommunityVO;
import com.myschool.VO.ItemVO;
import com.myschool.VO.MemoVO;
import com.myschool.VO.RentalVO;
import com.myschool.VO.StudentInfoVO;
import com.myschool.VO.StudentVO;
import com.myschool.VO.doneVO;
import com.myschool.mapper.StudentMapper;

@Service("studentService")
public class StudentServiceImpl implements StudentService {

	@Autowired
	private StudentMapper mapper;
	
	@Override
	public void attendStudent(StudentVO StudentVO) {
		// TODO Auto-generated method stub
		mapper.attendStudent(StudentVO);
	}
	
	@Override
	public String getStudentSalt(String Studentnum) {
		// TODO Auto-generated method stub
		return mapper.getStudentSalt(Studentnum);
	}
	
	@Override
	public StudentInfoVO getStudentInfo(StudentInfoVO vo) {
		return mapper.getStudentInfo(vo);
	}
	
	@Override
	public void insertStudent(StudentInfoVO vo){
		mapper.insertStudent(vo);
	}
	
	@Override
	public List<StudentVO> getAttendList(String num){
		return mapper.getAttendList(num);
	}
	
	@Override
	public List<StudentVO> getAttendingList(String date){
		return mapper.getAttendingList(date);
	}
	
	@Override
	public List<StudentVO> getAttendedList(String date){
		return mapper.getAttendedList(date);
	}

	@Override
	public String getCheckDate(String date, String num) {
		return mapper.getCheckDate(date, num);
	}
	
	@Override
	public List<StudentVO> getCheckAlltime(String date, String num){
		return mapper.getCheckAlltime(date, num);
	}
	
	@Override
	public  List<StudentInfoVO> getAllUser(){
		return mapper.getAllUser();
	}
	
	@Override
	public String getStudentName(String num) {
		return mapper.getStudentName(num);
	}
	
	@Override
	public List<StudentVO> getAttendNameList(String name){
		return mapper.getAttendNameList(name);
	}
	
	@Override
	public void updateImg(StudentInfoVO studentInfoVO) {
		mapper.updateImg(studentInfoVO);
	}
	
	@Override
	public StudentInfoVO getStudent(String name) {
		return mapper.getStudent(name);
	}
	
	@Override
	public String getStudentimgsrc(String name) {
		return mapper.getStudentimgsrc(name);
	}
	
	@Override
	public void insertMemo(MemoVO MemoVO) {
		mapper.insertMemo(MemoVO);
	}
	
	@Override
	public List<MemoVO> getMemoList(){
		return mapper.getMemoList();
	}
	
	@Override
	public List<StudentInfoVO> getStuList(){
		return mapper.getStuList();
	}
	
	@Override
	public void insertCommunity(CommunityVO communityVO) {
		mapper.insertCommunity(communityVO);
	}
	
	@Override
	public List<CommunityVO> getCommunityList(){
		return mapper.getCommunityList();
	}
	
	@Override
	public CommunityVO getCommunityInfo(String numb) {
		return mapper.getCommunityInfo(numb);
	}
	
	@Override
	public void getCommunityDelete(String numb) {
		mapper.getCommunityDelete(numb);
	}
	@Override
	public List<CommunityVO> getCommunityListSearch(String categori){
		return mapper.getCommunityListSearch(categori);
	}
	@Override
	public List<CommunityVO> getCommunityListinputSearch(String title){
		return mapper.getCommunityListinputSearch(title);
	}
	@Override
	public void insertRental(RentalVO RentalVO) {
		mapper.insertRental(RentalVO);
	}
	
	@Override
	public List<RentalVO> getRentalList(){
		return mapper.getRentalList();
	}
	
	@Override
	public RentalVO getRentalInfo(String numb) {
		return mapper.getRentalInfo(numb);
	}
	
	@Override
	public void getRentalDelete(String numb) {
		 mapper.getRentalDelete(numb);
	}
	
	@Override
	public void updateDone(doneVO doneVO) {
		mapper.updateDone(doneVO);
	}
	
	@Override
	public List<RentalVO> getRentalListinputSearch(String title){
		return mapper.getRentalListinputSearch(title);
	}
	
	@Override
	public List<RentalVO> getRentalListSearch(String categori){
		return mapper.getRentalListSearch(categori);
	}
	
	@Override
	public void insertItem(ItemVO ItemVO) {
		mapper.insertItem(ItemVO);
	}
	
	@Override
	public List<ItemVO> getItemList(){
		return mapper.getItemList();
	}
	
	@Override
	public ItemVO getItemInfo(String num) {
		return mapper.getItemInfo(num);
	}
	
	@Override
	public void getItemDelete(String num) {
		mapper.getItemDelete(num);
	}
	
	@Override
	public List<ItemVO> getItemListinputSearch(String title){
		return mapper.getItemListinputSearch(title);
	}
	@Override
	public List<ItemVO> getItemListSearch(String categori){
		return mapper.getItemListSearch(categori);
	}
	@Override
	public void updateItem(ItemVO ItemVO) {
		mapper.updateItem(ItemVO);
	}
}
