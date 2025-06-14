from typing import List, Optional
from werkzeug.security import check_password_hash, generate_password_hash

from sqlalchemy import Column, ForeignKeyConstraint, Integer, Numeric, PrimaryKeyConstraint, String, Table, Text, UniqueConstraint, text
from sqlalchemy.orm import DeclarativeBase, Mapped, mapped_column, relationship
import decimal

class Base(DeclarativeBase):
    pass


class Lecturers(Base):
    __tablename__ = 'lecturers'
    __table_args__ = (
        PrimaryKeyConstraint('lecturer_id', name='lecturers_pkey'),
        UniqueConstraint('email', name='lecturers_email_key'),
        UniqueConstraint('phone', name='lecturers_phone_key')
    )

    lecturer_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    lecturer_first_name: Mapped[str] = mapped_column(String(30))
    lecturer_last_name: Mapped[str] = mapped_column(String(30))
    phone: Mapped[int] = mapped_column(Integer)
    email: Mapped[Optional[str]] = mapped_column(String(40))

    courses: Mapped[List['Courses']] = relationship('Courses', back_populates='lecturer')
    tas: Mapped[List['Tas']] = relationship('Tas', back_populates='lecturer')


class Studentdeets(Base):
    __tablename__ = 'studentdeets'
    __table_args__ = (
        PrimaryKeyConstraint('student_id', name='studentdeets_pkey'),
        UniqueConstraint('email', name='studentdeets_email_key'),
        UniqueConstraint('phone', name='studentdeets_phone_key')
    )

    student_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    first_name: Mapped[str] = mapped_column(String(30))
    last_name: Mapped[str] = mapped_column(String(30))
    phone: Mapped[int] = mapped_column(Integer)
    email: Mapped[Optional[str]] = mapped_column(String(50))

    course: Mapped[List['Courses']] = relationship('Courses', secondary='courseenrollments', back_populates='student')
    feespayment: Mapped[List['Feespayment']] = relationship('Feespayment', back_populates='student')


class Users(Base):
    __tablename__ = 'users'
    __table_args__ = (
        PrimaryKeyConstraint('id', name='users_pkey'),
        UniqueConstraint('email', name='users_email_key'),
        UniqueConstraint('username', name='users_username_key')
    )

    id: Mapped[int] = mapped_column(Integer, primary_key=True)
    password_hash: Mapped[str] = mapped_column(String(170))
    email: Mapped[Optional[str]] = mapped_column(String(120))
    username: Mapped[Optional[str]] = mapped_column(String(40))

    def set_password(self, password: str) -> None:
        self.password_hash = generate_password_hash(password)

    def check_password(self, password:str) -> bool:
        return check_password_hash(self.password_hash, password)


class Courses(Base):
    __tablename__ = 'courses'
    __table_args__ = (
        ForeignKeyConstraint(['lecturer_id'], ['lecturers.lecturer_id'], name='courses_lecturer_id_fkey'),
        PrimaryKeyConstraint('course_id', name='courses_pkey'),
        UniqueConstraint('course_name', name='courses_course_name_key')
    )

    course_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    course_name: Mapped[str] = mapped_column(String(40))
    course_description: Mapped[str] = mapped_column(Text)
    lecturer_id: Mapped[Optional[int]] = mapped_column(Integer)

    lecturer: Mapped[Optional['Lecturers']] = relationship('Lecturers', back_populates='courses')
    student: Mapped[List['Studentdeets']] = relationship('Studentdeets', secondary='courseenrollments', back_populates='course')


class Feespayment(Base):
    __tablename__ = 'feespayment'
    __table_args__ = (
        ForeignKeyConstraint(['student_id'], ['studentdeets.student_id'], name='feespayment_student_id_fkey'),
        PrimaryKeyConstraint('payment_id', name='feespayment_pkey')
    )

    payment_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    student_id: Mapped[Optional[int]] = mapped_column(Integer)
    amount_paid: Mapped[Optional[decimal.Decimal]] = mapped_column(Numeric(10, 2), server_default=text('0'))

    student: Mapped[Optional['Studentdeets']] = relationship('Studentdeets', back_populates='feespayment')


class Tas(Base):
    __tablename__ = 'tas'
    __table_args__ = (
        ForeignKeyConstraint(['lecturer_id'], ['lecturers.lecturer_id'], name='tas_lecturer_id_fkey'),
        PrimaryKeyConstraint('ta_id', name='tas_pkey'),
        UniqueConstraint('ta_email', name='tas_ta_email_key'),
        UniqueConstraint('ta_phone', name='tas_ta_phone_key')
    )

    ta_id: Mapped[int] = mapped_column(Integer, primary_key=True)
    ta_first_name: Mapped[str] = mapped_column(String(30))
    ta_last_name: Mapped[str] = mapped_column(String(30))
    ta_phone: Mapped[int] = mapped_column(Integer)
    ta_email: Mapped[Optional[str]] = mapped_column(String(40))
    lecturer_id: Mapped[Optional[int]] = mapped_column(Integer)

    lecturer: Mapped[Optional['Lecturers']] = relationship('Lecturers', back_populates='tas')


t_courseenrollments = Table(
    'courseenrollments', Base.metadata,
    Column('student_id', Integer),
    Column('course_id', Integer),
    ForeignKeyConstraint(['course_id'], ['courses.course_id'], name='courseenrollments_course_id_fkey'),
    ForeignKeyConstraint(['student_id'], ['studentdeets.student_id'], name='courseenrollments_student_id_fkey')
)
