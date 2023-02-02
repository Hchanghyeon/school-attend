package com.myschool.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import com.myschool.VO.CommunityVO;
import com.myschool.VO.ItemVO;
import com.myschool.VO.MemoVO;
import com.myschool.VO.RentalVO;
import com.myschool.VO.StudentInfoVO;
import com.myschool.VO.StudentVO;
import com.myschool.VO.doneVO;

public interface StudentService {
	void attendStudent(StudentVO StudentVO);
	String getStudentSalt(String Studentnum);
	StudentInfoVO getStudentInfo(StudentInfoVO vo);
	void insertStudent(StudentInfoVO vo);
	public List<StudentVO> getAttendList(String num);
	public List<StudentVO> getAttendingList(String date);
	public List<StudentVO> getAttendedList(String date);
	public String getCheckDate(String date, String num);
	public List<StudentVO> getCheckAlltime(String date, String num);
	public List<StudentInfoVO> getAllUser();
	public String getStudentName(String num);
	public List<StudentVO> getAttendNameList(String name);
	public void updateImg(StudentInfoVO studentInfoVO);
	public StudentInfoVO getStudent(String name);
	public String getStudentimgsrc(String name);
	public void insertMemo(MemoVO MemoVO);
	public List<MemoVO> getMemoList();
	public List<StudentInfoVO> getStuList();
	public void insertCommunity(CommunityVO communityVO);
	public List<CommunityVO> getCommunityList();
	public CommunityVO getCommunityInfo(String numb);
	public void getCommunityDelete(String numb);
	public List<CommunityVO> getCommunityListSearch(String categori);
	public List<CommunityVO> getCommunityListinputSearch(String title);
	public void insertRental(RentalVO RentalVO);
	public List<RentalVO> getRentalList();
	public RentalVO getRentalInfo(String numb);
	public void getRentalDelete(String numb);
	public List<RentalVO> getRentalListinputSearch(String title);
	public List<RentalVO> getRentalListSearch(String categori);
	public void updateDone(doneVO doneVO);
	public void insertItem(ItemVO ItemVO);
	public List<ItemVO> getItemList();
	public ItemVO getItemInfo(String num);
	public void getItemDelete(String num);
	public List<ItemVO> getItemListinputSearch(String title);
	public List<ItemVO> getItemListSearch(String categori);
	public void updateItem(ItemVO ItemVO);
}
