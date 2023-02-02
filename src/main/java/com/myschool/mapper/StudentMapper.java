package com.myschool.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.myschool.VO.CommunityVO;
import com.myschool.VO.ItemVO;
import com.myschool.VO.MemoVO;
import com.myschool.VO.RentalVO;
import com.myschool.VO.StudentInfoVO;
import com.myschool.VO.StudentVO;
import com.myschool.VO.doneVO;


public interface StudentMapper {
	@Insert("insert into attend values(#{num}, #{name},#{attend},#{date},#{time})")
	public void attendStudent(StudentVO StudentVO);
	
	// 메모 등록에 쓰기
	@Insert("insert into memo(date, memo, name, num) values(#{date}, #{memo}, #{name}, #{num})")
	public void insertMemo(MemoVO MemoVO);
	
	
	@Insert("insert into community(date, categori, title, content, name, num, filesrc) values(#{date},#{categori}, #{title}, #{content}, #{name}, #{num}, #{filesrc})")
	public void insertCommunity(CommunityVO communityVO);
	
	
	@Insert("insert into rental(date, categori, studentnum, studentname, title, content, name, num) values(#{date},#{categori}, #{studentnum}, #{studentname}, #{title}, #{content}, #{name}, #{num})")
	public void insertRental(RentalVO RentalVO);
	
	
	
	
	@Insert("insert into itemlist(categori, itemloc, itemname, itemname2, itemcount, date, studentnum, studentname) values(#{categori}, #{itemloc}, #{itemname}, #{itemname2}, #{itemcount}, #{date}, #{studentnum}, #{studentname})")
	public void insertItem(ItemVO ItemVO);
	
	@Select("select * from itemlist order by itemname asc")
	public List<ItemVO> getItemList();
	
	@Select("select * from itemlist where num=#{num}")
	public ItemVO getItemInfo(String num);
	
	
	@Select("select * from itemlist where categori=#{categori} order by itemname asc")
	public List<ItemVO> getItemListSearch(String categori);
	
	@Select("select * from itemlist where itemname like '%' #{title} '%' order by itemname asc")
	public List<ItemVO> getItemListinputSearch(String title);
	
	@Select("select * from user")
	public  List<StudentInfoVO> getAllUser();
	
	@Select("select salt from user where num=#{num}")
	public String getStudentSalt(String Studentnum);
	
	@Select("select name from user where num=#{num}")
	public String getStudentName(String num);
	
	@Select("select * from community where numb=#{numb}")
	public CommunityVO getCommunityInfo(String numb);
	
	@Select("select * from rental where numb=#{numb}")
	public RentalVO getRentalInfo(String numb);
	
	@Delete("DELETE FROM community WHERE numb=#{numb}")
	public void getCommunityDelete(String numb);
	
	@Delete("DELETE FROM rental WHERE numb=#{numb}")
	public void getRentalDelete(String numb);
	
	@Delete("DELETE FROM itemlist WHERE num=#{num}")
	public void getItemDelete(String num);
	
	// 계정의 ID와 PWD로 조회 (로그인 처리에 쓰임)
	@Select("select * from user where num=#{num} and pwd=#{pwd}")
	public StudentInfoVO getStudentInfo(StudentInfoVO vo);

	@Select("select * from user where num=#{num}")
	public StudentInfoVO getStudent(String name);
	
	@Select("select imgsrc from user where num=#{num}")
	public String getStudentimgsrc(String name);
	
	@Select("select * from memo order by numb desc")
	public List<MemoVO> getMemoList();
	
	@Insert("insert into user(num, salt, pwd, name, com, sel) values(#{num},#{salt},#{pwd},#{name},#{com},#{sel})")
	public void insertStudent(StudentInfoVO VO);
	
	@Select("select * from attend where num=#{num} order by date asc")
	public List<StudentVO> getAttendList(String num);
	
	@Select("select * from attend where name=#{name} order by date asc")
	public List<StudentVO> getAttendNameList(String name);
	
	@Select("select * from attend where date like '%' #{date} '%' and attend ='출석'")
	public List<StudentVO> getAttendingList(String date);
	
	@Select("select * from attend where date like '%' #{date} '%' and attend ='퇴근'")
	public List<StudentVO> getAttendedList(String date);
	
	@Select("select * from user order by name asc")
	public List<StudentInfoVO> getStuList();
	
	@Select("select numb, date, categori, title, name from community order by numb desc")
	public List<CommunityVO> getCommunityList();
	
	@Select("select numb, date, categori, studentname, title, done, name from rental order by numb desc")
	public List<RentalVO> getRentalList();
	
	@Select("select numb, date, categori, studentname, title, done, name from rental where categori=#{categori} order by numb desc")
	public List<RentalVO> getRentalListSearch(String categori);
	
	@Select("select numb, date, categori, studentname, title, done, name from rental where title like '%' #{title} '%' order by numb desc")
	public List<RentalVO> getRentalListinputSearch(String title);
	
	
	
	
	@Select("select numb, date, categori, title, name from community where categori=#{categori} order by numb desc")
	public List<CommunityVO> getCommunityListSearch(String categori);
	
	@Select("select numb, date, categori, title, name from community where title like '%' #{title} '%' order by numb desc")
	public List<CommunityVO> getCommunityListinputSearch(String title);
	
	@Select("select date from attend where date like '%' #{date} '%' and attend ='출석' and num=#{num}")
	public String getCheckDate(@Param("date") String date, @Param("num") String num);
	
	@Select("select * from attend where date like '%' #{date} '%' and attend ='퇴근' and num=#{num}")
	public List<StudentVO> getCheckAlltime(@Param("date") String date, @Param("num") String num);
	
	//프로필 사진 업데이트
	@Update("update user set imgsrc=#{imgsrc} where num=#{num}")
	public void updateImg(StudentInfoVO studentInfoVO);

	@Update("update rental set done='완료', done_stu=#{done_stu} where numb=#{numb}")
	public void updateDone(doneVO doneVO);
	
	
	@Update("update itemlist set itemcount=#{itemcount} where num=#{num}")
	public void updateItem(ItemVO ItemVO);
	
}
