PGDMP      $                }            School    17.0    17.0 C    I           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            J           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            K           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            L           1262    223070    School    DATABASE     �   CREATE DATABASE "School" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "School";
                     postgres    false            �            1255    223231 %   calcoutstandingfees(integer, numeric)    FUNCTION     	  CREATE FUNCTION public.calcoutstandingfees(st_id integer, total_amount numeric) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE 
	result JSON;
BEGIN
	
	
	SELECT 
	json_build_object(
		'first_name', first_name,
		'last_name', last_name,
		'outstanding_fees', (SELECT (total_amount - amount_paid)
							FROM feesPayment WHERE student_id = st_id)		
	)
	INTO result
	FROM studentDeets JOIN feesPayment ON studentDeets.student_id = feesPayment.student_id
	WHERE studentDeets.student_id = st_id;

	RETURN result;
END;
$$;
 O   DROP FUNCTION public.calcoutstandingfees(st_id integer, total_amount numeric);
       public               postgres    false            �            1255    223472    calcoutstandingfeesall(numeric)    FUNCTION     �  CREATE FUNCTION public.calcoutstandingfeesall(total_amount numeric) RETURNS json
    LANGUAGE plpgsql
    AS $$
DECLARE 
	result JSON;
BEGIN
	
	SELECT json_agg(
	json_build_object(
		'first_name', first_name,
		'last_name', last_name,
		'outstanding_fees', (SELECT total_amount - feesPayment.amount_paid)
	))
	INTO result
	FROM studentDeets JOIN feesPayment ON studentDeets.student_id = feesPayment.student_id;
	RETURN result;
END;
$$;
 C   DROP FUNCTION public.calcoutstandingfeesall(total_amount numeric);
       public               postgres    false            �            1259    223495    _prisma_migrations    TABLE     �  CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);
 &   DROP TABLE public._prisma_migrations;
       public         heap r       postgres    false            �            1259    223442    courseenrollments    TABLE     Y   CREATE TABLE public.courseenrollments (
    student_id integer,
    course_id integer
);
 %   DROP TABLE public.courseenrollments;
       public         heap r       postgres    false            �            1259    223414    courses    TABLE     �   CREATE TABLE public.courses (
    course_id integer NOT NULL,
    course_name character varying(40) NOT NULL,
    course_description text NOT NULL,
    lecturer_id integer
);
    DROP TABLE public.courses;
       public         heap r       postgres    false            �            1259    223413    courses_course_id_seq    SEQUENCE     �   CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.courses_course_id_seq;
       public               postgres    false    222            M           0    0    courses_course_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;
          public               postgres    false    221            �            1259    223430    feespayment    TABLE     �   CREATE TABLE public.feespayment (
    payment_id integer NOT NULL,
    student_id integer,
    amount_paid numeric(10,2) DEFAULT 0
);
    DROP TABLE public.feespayment;
       public         heap r       postgres    false            �            1259    223429    feespayment_payment_id_seq    SEQUENCE     �   CREATE SEQUENCE public.feespayment_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 1   DROP SEQUENCE public.feespayment_payment_id_seq;
       public               postgres    false    224            N           0    0    feespayment_payment_id_seq    SEQUENCE OWNED BY     Y   ALTER SEQUENCE public.feespayment_payment_id_seq OWNED BY public.feespayment.payment_id;
          public               postgres    false    223            �            1259    223403 	   lecturers    TABLE     �   CREATE TABLE public.lecturers (
    lecturer_id integer NOT NULL,
    lecturer_first_name character varying(30) NOT NULL,
    lecturer_last_name character varying(30) NOT NULL,
    email character varying(40),
    phone integer NOT NULL
);
    DROP TABLE public.lecturers;
       public         heap r       postgres    false            �            1259    223402    lecturers_lecturer_id_seq    SEQUENCE     �   CREATE SEQUENCE public.lecturers_lecturer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.lecturers_lecturer_id_seq;
       public               postgres    false    220            O           0    0    lecturers_lecturer_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.lecturers_lecturer_id_seq OWNED BY public.lecturers.lecturer_id;
          public               postgres    false    219            �            1259    223392    studentdeets    TABLE     �   CREATE TABLE public.studentdeets (
    student_id integer NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(50),
    phone integer NOT NULL
);
     DROP TABLE public.studentdeets;
       public         heap r       postgres    false            �            1259    223391    studentdeets_student_id_seq    SEQUENCE     �   CREATE SEQUENCE public.studentdeets_student_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.studentdeets_student_id_seq;
       public               postgres    false    218            P           0    0    studentdeets_student_id_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.studentdeets_student_id_seq OWNED BY public.studentdeets.student_id;
          public               postgres    false    217            �            1259    223456    tas    TABLE     �   CREATE TABLE public.tas (
    ta_id integer NOT NULL,
    ta_first_name character varying(30) NOT NULL,
    ta_last_name character varying(30) NOT NULL,
    ta_email character varying(40),
    ta_phone integer NOT NULL,
    lecturer_id integer
);
    DROP TABLE public.tas;
       public         heap r       postgres    false            �            1259    223455    tas_ta_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tas_ta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.tas_ta_id_seq;
       public               postgres    false    227            Q           0    0    tas_ta_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.tas_ta_id_seq OWNED BY public.tas.ta_id;
          public               postgres    false    226            �            1259    223485    users    TABLE     �   CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying(120),
    password_hash character varying(170) NOT NULL,
    username character varying(40)
);
    DROP TABLE public.users;
       public         heap r       postgres    false            �            1259    223484    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public               postgres    false    229            R           0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public               postgres    false    228            |           2604    223417    courses course_id    DEFAULT     v   ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);
 @   ALTER TABLE public.courses ALTER COLUMN course_id DROP DEFAULT;
       public               postgres    false    221    222    222            }           2604    223433    feespayment payment_id    DEFAULT     �   ALTER TABLE ONLY public.feespayment ALTER COLUMN payment_id SET DEFAULT nextval('public.feespayment_payment_id_seq'::regclass);
 E   ALTER TABLE public.feespayment ALTER COLUMN payment_id DROP DEFAULT;
       public               postgres    false    224    223    224            {           2604    223406    lecturers lecturer_id    DEFAULT     ~   ALTER TABLE ONLY public.lecturers ALTER COLUMN lecturer_id SET DEFAULT nextval('public.lecturers_lecturer_id_seq'::regclass);
 D   ALTER TABLE public.lecturers ALTER COLUMN lecturer_id DROP DEFAULT;
       public               postgres    false    220    219    220            z           2604    223395    studentdeets student_id    DEFAULT     �   ALTER TABLE ONLY public.studentdeets ALTER COLUMN student_id SET DEFAULT nextval('public.studentdeets_student_id_seq'::regclass);
 F   ALTER TABLE public.studentdeets ALTER COLUMN student_id DROP DEFAULT;
       public               postgres    false    218    217    218                       2604    223459 	   tas ta_id    DEFAULT     f   ALTER TABLE ONLY public.tas ALTER COLUMN ta_id SET DEFAULT nextval('public.tas_ta_id_seq'::regclass);
 8   ALTER TABLE public.tas ALTER COLUMN ta_id DROP DEFAULT;
       public               postgres    false    227    226    227            �           2604    223488    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    229    228    229            F          0    223495    _prisma_migrations 
   TABLE DATA           �   COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
    public               postgres    false    230   9T       A          0    223442    courseenrollments 
   TABLE DATA           B   COPY public.courseenrollments (student_id, course_id) FROM stdin;
    public               postgres    false    225   �T       >          0    223414    courses 
   TABLE DATA           Z   COPY public.courses (course_id, course_name, course_description, lecturer_id) FROM stdin;
    public               postgres    false    222   �T       @          0    223430    feespayment 
   TABLE DATA           J   COPY public.feespayment (payment_id, student_id, amount_paid) FROM stdin;
    public               postgres    false    224   vU       <          0    223403 	   lecturers 
   TABLE DATA           g   COPY public.lecturers (lecturer_id, lecturer_first_name, lecturer_last_name, email, phone) FROM stdin;
    public               postgres    false    220   �U       :          0    223392    studentdeets 
   TABLE DATA           W   COPY public.studentdeets (student_id, first_name, last_name, email, phone) FROM stdin;
    public               postgres    false    218   V       C          0    223456    tas 
   TABLE DATA           b   COPY public.tas (ta_id, ta_first_name, ta_last_name, ta_email, ta_phone, lecturer_id) FROM stdin;
    public               postgres    false    227   �V       E          0    223485    users 
   TABLE DATA           C   COPY public.users (id, email, password_hash, username) FROM stdin;
    public               postgres    false    229   	W       S           0    0    courses_course_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.courses_course_id_seq', 3, true);
          public               postgres    false    221            T           0    0    feespayment_payment_id_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public.feespayment_payment_id_seq', 4, true);
          public               postgres    false    223            U           0    0    lecturers_lecturer_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.lecturers_lecturer_id_seq', 2, true);
          public               postgres    false    219            V           0    0    studentdeets_student_id_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.studentdeets_student_id_seq', 4, true);
          public               postgres    false    217            W           0    0    tas_ta_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.tas_ta_id_seq', 2, true);
          public               postgres    false    226            X           0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 5, true);
          public               postgres    false    228            �           2606    223503 *   _prisma_migrations _prisma_migrations_pkey 
   CONSTRAINT     h   ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);
 T   ALTER TABLE ONLY public._prisma_migrations DROP CONSTRAINT _prisma_migrations_pkey;
       public                 postgres    false    230            �           2606    223423    courses courses_course_name_key 
   CONSTRAINT     a   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_course_name_key UNIQUE (course_name);
 I   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_course_name_key;
       public                 postgres    false    222            �           2606    223421    courses courses_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);
 >   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_pkey;
       public                 postgres    false    222            �           2606    223436    feespayment feespayment_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.feespayment
    ADD CONSTRAINT feespayment_pkey PRIMARY KEY (payment_id);
 F   ALTER TABLE ONLY public.feespayment DROP CONSTRAINT feespayment_pkey;
       public                 postgres    false    224            �           2606    223410    lecturers lecturers_email_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_email_key UNIQUE (email);
 G   ALTER TABLE ONLY public.lecturers DROP CONSTRAINT lecturers_email_key;
       public                 postgres    false    220            �           2606    223412    lecturers lecturers_phone_key 
   CONSTRAINT     Y   ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_phone_key UNIQUE (phone);
 G   ALTER TABLE ONLY public.lecturers DROP CONSTRAINT lecturers_phone_key;
       public                 postgres    false    220            �           2606    223408    lecturers lecturers_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.lecturers
    ADD CONSTRAINT lecturers_pkey PRIMARY KEY (lecturer_id);
 B   ALTER TABLE ONLY public.lecturers DROP CONSTRAINT lecturers_pkey;
       public                 postgres    false    220            �           2606    223399 #   studentdeets studentdeets_email_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.studentdeets
    ADD CONSTRAINT studentdeets_email_key UNIQUE (email);
 M   ALTER TABLE ONLY public.studentdeets DROP CONSTRAINT studentdeets_email_key;
       public                 postgres    false    218            �           2606    223401 #   studentdeets studentdeets_phone_key 
   CONSTRAINT     _   ALTER TABLE ONLY public.studentdeets
    ADD CONSTRAINT studentdeets_phone_key UNIQUE (phone);
 M   ALTER TABLE ONLY public.studentdeets DROP CONSTRAINT studentdeets_phone_key;
       public                 postgres    false    218            �           2606    223397    studentdeets studentdeets_pkey 
   CONSTRAINT     d   ALTER TABLE ONLY public.studentdeets
    ADD CONSTRAINT studentdeets_pkey PRIMARY KEY (student_id);
 H   ALTER TABLE ONLY public.studentdeets DROP CONSTRAINT studentdeets_pkey;
       public                 postgres    false    218            �           2606    223461    tas tas_pkey 
   CONSTRAINT     M   ALTER TABLE ONLY public.tas
    ADD CONSTRAINT tas_pkey PRIMARY KEY (ta_id);
 6   ALTER TABLE ONLY public.tas DROP CONSTRAINT tas_pkey;
       public                 postgres    false    227            �           2606    223463    tas tas_ta_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.tas
    ADD CONSTRAINT tas_ta_email_key UNIQUE (ta_email);
 >   ALTER TABLE ONLY public.tas DROP CONSTRAINT tas_ta_email_key;
       public                 postgres    false    227            �           2606    223465    tas tas_ta_phone_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.tas
    ADD CONSTRAINT tas_ta_phone_key UNIQUE (ta_phone);
 >   ALTER TABLE ONLY public.tas DROP CONSTRAINT tas_ta_phone_key;
       public                 postgres    false    227            �           2606    223492    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public                 postgres    false    229            �           2606    223490    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public                 postgres    false    229            �           2606    223494    users users_username_key 
   CONSTRAINT     W   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_username_key;
       public                 postgres    false    229            �           2606    223450 2   courseenrollments courseenrollments_course_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.courseenrollments
    ADD CONSTRAINT courseenrollments_course_id_fkey FOREIGN KEY (course_id) REFERENCES public.courses(course_id);
 \   ALTER TABLE ONLY public.courseenrollments DROP CONSTRAINT courseenrollments_course_id_fkey;
       public               postgres    false    225    4754    222            �           2606    223445 3   courseenrollments courseenrollments_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.courseenrollments
    ADD CONSTRAINT courseenrollments_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.studentdeets(student_id);
 ]   ALTER TABLE ONLY public.courseenrollments DROP CONSTRAINT courseenrollments_student_id_fkey;
       public               postgres    false    4744    225    218            �           2606    223424     courses courses_lecturer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturers(lecturer_id);
 J   ALTER TABLE ONLY public.courses DROP CONSTRAINT courses_lecturer_id_fkey;
       public               postgres    false    222    220    4750            �           2606    223437 '   feespayment feespayment_student_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.feespayment
    ADD CONSTRAINT feespayment_student_id_fkey FOREIGN KEY (student_id) REFERENCES public.studentdeets(student_id);
 Q   ALTER TABLE ONLY public.feespayment DROP CONSTRAINT feespayment_student_id_fkey;
       public               postgres    false    4744    218    224            �           2606    223466    tas tas_lecturer_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tas
    ADD CONSTRAINT tas_lecturer_id_fkey FOREIGN KEY (lecturer_id) REFERENCES public.lecturers(lecturer_id);
 B   ALTER TABLE ONLY public.tas DROP CONSTRAINT tas_lecturer_id_fkey;
       public               postgres    false    220    227    4750            F   ~   x��ʹ�0 �Z�"} ���	)nRed�\}�;�!R���L�2V���H��#iX]�M,�Ѩ�K� Y�Ls������Ʈ\G" -P��=��֩C$xߟ������u�~�+      A   $   x�3�4�2�4�2�F��\�@�	�md��qqq CA�      >   k   x�5�A
�@@�ur���8�j.�[72C�&%I�ނ�~�_`|Lw*�WM�eo)��F��۞�4iev�뿨p�.�z����5<����4�ͭq�y@�瀈_�#!�      @   /   x�%�� 0�7A�N�����e��H!1�p��}���$�<       <   O   x�3������t�O��2�R�SJ�2�R��3K*�RSJ9�������8݋�S9S�R39�Al�DS���9W� ��3      :      x�e��
�@���ۘ�*X�X6�,���p����M���a*l��`}�;4(����0<��1��8i�a�5�Q�d�E�2�2o�U-$إ�<��:�����8�q�\�ϗ�7L���d����3�i�:2      C   V   x�3���O��t,N,J��2�AL�Ҽ̲Ԣ�̒J�ԔRN#cc#cNC.#N���DN�Լ�����D O/�æˀӈ+F��� @�!N      E   �  x�m�Ko�PF���`����U��hP
)I�n��;1�N�ȯ���R�F��G��*��T�[,bSe��;��RX����{���9�������a #*��dt�h�9
F:	�D�h�����*�A[dD.Db�[FZ�7��|�ܠLh���������5(�l��󘽮_�X5u.�U�����rU����u�8������������(LP��0Z1��Nd=g�Ĭ�]#�ɀB�i+L(�9W
Q�@�{&���%Σ��I��L��I	Ҭ�!щc$R"�w�\fM����D�qֳ�RZ\�l�ƫ�l�t�t1�?.[ad=i�[�^<����=�#�qs����De%T/p�ƥ�H������}z������j.@��\.O�a9=���3�<��?0��:�ԛ���[q��ٷ;�oZ9���8����˓�y�=̝i�I����0`�kS���E���P�     