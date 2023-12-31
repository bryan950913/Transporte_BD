PGDMP         :        
    	    {         
   transporte    15.4    15.4 &    (           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            )           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            *           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            +           1262    24595 
   transporte    DATABASE     �   CREATE DATABASE transporte WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Spanish_Colombia.1252';
    DROP DATABASE transporte;
                postgres    false            �            1255    24849    impl()    FUNCTION       CREATE FUNCTION public.impl() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE 
	rec record;
	cont int := 0;
BEGIN 
	FOR rec IN SELECT * FROM pasajeros LOOP
		cont := cont + 1;
	END LOOP;
	INSERT INTO cont_pasajeros(total,tiempo)
	VALUES (cont,now());
	RETURN NEW;
END
$$;
    DROP FUNCTION public.impl();
       public          postgres    false            �            1259    24839    cont_pasajeros    TABLE     s   CREATE TABLE public.cont_pasajeros (
    total integer,
    tiempo time with time zone,
    id integer NOT NULL
);
 "   DROP TABLE public.cont_pasajeros;
       public         heap    postgres    false            �            1259    24838    cont_pasajeros_id_seq    SEQUENCE     �   CREATE SEQUENCE public.cont_pasajeros_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.cont_pasajeros_id_seq;
       public          postgres    false    221            ,           0    0    cont_pasajeros_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.cont_pasajeros_id_seq OWNED BY public.cont_pasajeros.id;
          public          postgres    false    220            �            1259    24716 
   estaciones    TABLE     �   CREATE TABLE public.estaciones (
    idestaciones integer NOT NULL,
    nombre character varying(125),
    direccion character varying(125)
);
    DROP TABLE public.estaciones;
       public         heap    postgres    false            -           0    0    TABLE estaciones    ACL     =   GRANT SELECT ON TABLE public.estaciones TO usuario_consulta;
          public          postgres    false    216            �            1259    24706 	   pasajeros    TABLE     �   CREATE TABLE public.pasajeros (
    idpasajeros integer NOT NULL,
    nombre character varying(125),
    direccionresidencia character varying(125),
    fechanacimiento date
);
    DROP TABLE public.pasajeros;
       public         heap    postgres    false            .           0    0    TABLE pasajeros    ACL     <   GRANT SELECT ON TABLE public.pasajeros TO usuario_consulta;
          public          postgres    false    214            �            1259    24796 
   rango_view    VIEW     2  CREATE VIEW public.rango_view AS
 SELECT pasajeros.nombre,
    pasajeros.fechanacimiento,
        CASE
            WHEN ((pasajeros.nombre)::text ~~* 'a%'::text) THEN 'Vocal A'::text
            WHEN ((pasajeros.nombre)::text ~~* 'e%'::text) THEN 'Vocal E'::text
            WHEN ((pasajeros.nombre)::text ~~* 'i%'::text) THEN 'Vocal I'::text
            WHEN ((pasajeros.nombre)::text ~~* 'o%'::text) THEN 'Vocal O'::text
            WHEN ((pasajeros.nombre)::text ~~* 'u%'::text) THEN 'Vocal U'::text
            ELSE concat('Abecedario', ' ', "substring"((pasajeros.nombre)::text, 1, 1))
        END AS "Nombres Vocales",
        CASE
            WHEN (pasajeros.fechanacimiento < '2005-01-01'::date) THEN 'Mayor de Edad'::text
            ELSE 'Menor de Edad'::text
        END AS "EDAD"
   FROM public.pasajeros;
    DROP VIEW public.rango_view;
       public          postgres    false    214    214            �            1259    24721 	   trayectos    TABLE     p   CREATE TABLE public.trayectos (
    idtrayectos integer NOT NULL,
    idestacion integer,
    idtren integer
);
    DROP TABLE public.trayectos;
       public         heap    postgres    false            /           0    0    TABLE trayectos    ACL     <   GRANT SELECT ON TABLE public.trayectos TO usuario_consulta;
          public          postgres    false    217            �            1259    24711    trenes    TABLE     �   CREATE TABLE public.trenes (
    idtrenes integer NOT NULL,
    modelo character varying(125),
    capacidad character varying(125)
);
    DROP TABLE public.trenes;
       public         heap    postgres    false            0           0    0    TABLE trenes    ACL     9   GRANT SELECT ON TABLE public.trenes TO usuario_consulta;
          public          postgres    false    215            �            1259    24736    viajes    TABLE     �   CREATE TABLE public.viajes (
    idviajes integer NOT NULL,
    idpasajero integer,
    idtrayecto integer,
    inicio time without time zone,
    fin time without time zone
);
    DROP TABLE public.viajes;
       public         heap    postgres    false            1           0    0    TABLE viajes    ACL     9   GRANT SELECT ON TABLE public.viajes TO usuario_consulta;
          public          postgres    false    218            ~           2604    24842    cont_pasajeros id    DEFAULT     v   ALTER TABLE ONLY public.cont_pasajeros ALTER COLUMN id SET DEFAULT nextval('public.cont_pasajeros_id_seq'::regclass);
 @   ALTER TABLE public.cont_pasajeros ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    221    220    221            %          0    24839    cont_pasajeros 
   TABLE DATA           ;   COPY public.cont_pasajeros (total, tiempo, id) FROM stdin;
    public          postgres    false    221   �+       !          0    24716 
   estaciones 
   TABLE DATA           E   COPY public.estaciones (idestaciones, nombre, direccion) FROM stdin;
    public          postgres    false    216   ,                 0    24706 	   pasajeros 
   TABLE DATA           ^   COPY public.pasajeros (idpasajeros, nombre, direccionresidencia, fechanacimiento) FROM stdin;
    public          postgres    false    214   �4       "          0    24721 	   trayectos 
   TABLE DATA           D   COPY public.trayectos (idtrayectos, idestacion, idtren) FROM stdin;
    public          postgres    false    217   @?                  0    24711    trenes 
   TABLE DATA           =   COPY public.trenes (idtrenes, modelo, capacidad) FROM stdin;
    public          postgres    false    215   A       #          0    24736    viajes 
   TABLE DATA           O   COPY public.viajes (idviajes, idpasajero, idtrayecto, inicio, fin) FROM stdin;
    public          postgres    false    218   �D       2           0    0    cont_pasajeros_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.cont_pasajeros_id_seq', 4, true);
          public          postgres    false    220            �           2606    24844 "   cont_pasajeros cont_pasajeros_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.cont_pasajeros
    ADD CONSTRAINT cont_pasajeros_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.cont_pasajeros DROP CONSTRAINT cont_pasajeros_pkey;
       public            postgres    false    221            �           2606    24720    estaciones id_estaciones_pk 
   CONSTRAINT     c   ALTER TABLE ONLY public.estaciones
    ADD CONSTRAINT id_estaciones_pk PRIMARY KEY (idestaciones);
 E   ALTER TABLE ONLY public.estaciones DROP CONSTRAINT id_estaciones_pk;
       public            postgres    false    216            �           2606    24710    pasajeros id_pasajeros_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.pasajeros
    ADD CONSTRAINT id_pasajeros_pk PRIMARY KEY (idpasajeros);
 C   ALTER TABLE ONLY public.pasajeros DROP CONSTRAINT id_pasajeros_pk;
       public            postgres    false    214            �           2606    24725    trayectos id_trayectos_pk 
   CONSTRAINT     `   ALTER TABLE ONLY public.trayectos
    ADD CONSTRAINT id_trayectos_pk PRIMARY KEY (idtrayectos);
 C   ALTER TABLE ONLY public.trayectos DROP CONSTRAINT id_trayectos_pk;
       public            postgres    false    217            �           2606    24715    trenes id_trenes_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.trenes
    ADD CONSTRAINT id_trenes_pk PRIMARY KEY (idtrenes);
 =   ALTER TABLE ONLY public.trenes DROP CONSTRAINT id_trenes_pk;
       public            postgres    false    215            �           2606    24740    viajes id_viajes_pk 
   CONSTRAINT     W   ALTER TABLE ONLY public.viajes
    ADD CONSTRAINT id_viajes_pk PRIMARY KEY (idviajes);
 =   ALTER TABLE ONLY public.viajes DROP CONSTRAINT id_viajes_pk;
       public            postgres    false    218            �           2620    24850    pasajeros mitrigger    TRIGGER     g   CREATE TRIGGER mitrigger AFTER INSERT ON public.pasajeros FOR EACH ROW EXECUTE FUNCTION public.impl();
 ,   DROP TRIGGER mitrigger ON public.pasajeros;
       public          postgres    false    222    214            �           2606    24726    trayectos id_estacion_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.trayectos
    ADD CONSTRAINT id_estacion_fk FOREIGN KEY (idestacion) REFERENCES public.estaciones(idestaciones);
 B   ALTER TABLE ONLY public.trayectos DROP CONSTRAINT id_estacion_fk;
       public          postgres    false    216    3204    217            �           2606    24741    viajes id_pasajero_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.viajes
    ADD CONSTRAINT id_pasajero_fk FOREIGN KEY (idpasajero) REFERENCES public.pasajeros(idpasajeros);
 ?   ALTER TABLE ONLY public.viajes DROP CONSTRAINT id_pasajero_fk;
       public          postgres    false    218    214    3200            �           2606    24746    viajes id_trayecto_fk    FK CONSTRAINT     �   ALTER TABLE ONLY public.viajes
    ADD CONSTRAINT id_trayecto_fk FOREIGN KEY (idtrayecto) REFERENCES public.trayectos(idtrayectos);
 ?   ALTER TABLE ONLY public.viajes DROP CONSTRAINT id_trayecto_fk;
       public          postgres    false    217    218    3206            �           2606    24731    trayectos id_tren_fk    FK CONSTRAINT     y   ALTER TABLE ONLY public.trayectos
    ADD CONSTRAINT id_tren_fk FOREIGN KEY (idtren) REFERENCES public.trenes(idtrenes);
 >   ALTER TABLE ONLY public.trayectos DROP CONSTRAINT id_tren_fk;
       public          postgres    false    3202    215    217            %   B   x����0�7�"���Z���p`�i�����
���k�V7+q"��=AcG�x�6U}?Q�      !   �  x�eW�r�:\C_��݈S|?���۱�v쪩�@$�*��������#�M�
!�>�}�	y`�׊�[�HU��~��$%L�D��v��R	�j���Y��IF>�ZK���F�`��dyI_[��4}��Mrr���qO����qh��L���`8&y�]����*�����ZB�II�$ʝR��XsC����G��eA�Ww��RN*r�䧶-F3����:)j:��C+No>���&7����q��$EYх�tnt���6�fٷ���ے��ta���3��I��Ū�[��p$�������$	q-F/zm�v�_$ɚ�(=S������Ԅ.���k���x�a{֢�7n��5#�L����9)sz��1Ӆ�r�`G`ǜ���6k.;���$e'���E�V ':�Bnƾ�����$�F���R�W�L����L��~�~�k3��֓��p����Ѭ����7;=���햫5�<�����Z�v�JF������k��q�1��M�Z����J���4���L	L3oҤ��G3�y���OquQ�U5}cR�x�媔<��ѽ�r/I+ �V\�)p_�G)��m����;A�p�����H�!(̀-�Z������SA���R���)�f�%�˨���k &��Kv`������Z�\B:��;���Un�Wx���B�IZ����Y�5���>�Ú�K�2��Z��|�=dw����8K�}�vt.�J�����זq���?�,&o�Y�/��<��8����z��1�C_��	�m��bN��YJ�	�g�*��qM<��,#3�V�D��}������M9�k)< N1*�(O����������	oB;.CU7�bC{$i�fN�l@��p��܌�O�$X���_@�);c�n�Pb\6MNbl���v�dV�����;�8"�È�+���z�H�Xs�ۣ��+�U��(�~l��>��<&�q.�C�xU;؁�w�8�����m?��[����b����)�} V���u����q�V'u�7���Kt���O��{�gq)����!�9�ķ�
,�a�X����]j�bi���Y?B*a�zSM�۳\���"&aUᕛ���1�A�T6�(*L�K�z�]3�+�w���2�����?DX�qNƮto�	`W�;��۹�� ,��`8��C{�yC�Z����.�TE���ǘnY��n�!z���'YZ0�UR$��q�]9L���e�(�iJ&/.Rl1�q�[���]va�E;Xr��W��'u
���YUEN|��C���Ut&G[�.�p�
�Z�>C��7��l�7T��q�a��-���\(^T�����'��*v������2����'q��ت[
��K'����g+��g� ���\�|�6 ��X)�,7'F���H�'3�/R&�]�1����$%VHb��
Я���~�;�X#���K��3~
Ȁ�i�gM�a7/�m;�T��2g�o�9qiƮ�X�vT��CBu�*��6ߨ�Ѻs�,�M3ѓBZu̹�q��
�F��:O�<�4��@xԀ������Y
�rŮ�W�!�R�e�C�W�*�]�1n-��������<�!LVn�U�}å]7P�Ft���{X�y� �g�Wi��� �
��#`sg-��@_X��I�Onc�eUA�CW�;��
�������Uiw'z�,�0N�
@�	ٹ¢S[ݷ�*I�a�:�+�`A4ST��APr�G�`�+��/�Q5סɮQ�0X�I}��\�u�GZ���Q�`X�g� @�����%�lga�u�n������d.(�W6Ug����V�4�_3�ol�5rd��so��f���o���y<B���j���!�Y��H.��vù�
�K����U֝�Y���yo>\BB��SGS�!�T$�[z�:4q(��
P���<j��q�Ǉ�o��z&,����o����q�3�B��H��{�G���i2��<Dsk��&��U�Wt��`���e譱;��A�ټ�7AZ���\uov��I�4nچܭ�i_@I`�d=��y���� ?Q������-�泷��/�jj��;���i3w�e�.;O�i�iZĎ�Ug!��Fb�͟l�;�='�$��/�RG�V)���>E���k2�����         k
  x��XIr�]���ҁ��RC��URY���6� IdN��AR��m�,���G��+GԢ[����Iv?3L��উ	�87��r
�NL	Q.D�P*Q��w�4+;�f�_�yj�z��,�	�\�|��D�W�Z9�lW�n�ė]�w#1a�dU�.d���Ǘ֬�k6�庐X�Mh�Kgj���X��"�س�u��[;���+R���x)]��Wi��[ӯ��ǎؚ�>���xXI�uR�{V|�z;���2SvВ���a��V�����*|�����N���+c����b7Ccu�6�ۛa@������s�dI�+�H�o�WϦ~�MG�*��u����zpl�(2O�d_q����a���e&4��΢������b��Db��<�;t��2]de��s���_i���� !�:-�ٓ��8�{��[�ڵH����pH"S�l��M��e���*S����6ñ"��XKdƾ|Џ�0P*S(~���8֔ &u"s��s��;̵̰ip�~0�΅���E�p"���m7��++��_}Q�j̶���_�>��s�b��Z���;��!\V��ث��?;3:��wÈI�o�POh2�-�\(�(��mW;��l����q���&K��"Q�}TF���c1U+
��4���O� ��+� �Z7��-�KQJ�Ӵ��:�?�%aPJ��`S�+��f�.-h���pH�>Gi��Rv@(C���aU.�Cp��訩�g�����ov��a�2p���w�q	�E\��?�i/߁¬J������
aPe�
`mF1�w��[B瑗��4G�hd
��S]��N�cE&��S;�N���}��繇��*��\�M�nU�{	3�Y[�캮��]��BC�n87;gq�d�"Lp�o���H�r�DK]���.����"ъ=\�����ar�`�隓���M)�ٝ�h���{h+U���>+I!�S��/�w�	1�aٳ5�ߝȫ�5�Dg�=Fv۹�e ~3���RiZ�R�i��e�:~gFS�����4W�Msm��G��3Q�x�K��,�$�=ړ�.P�5=+�;��ǭw�h����{��Wĭd�Q��4Ap�|�*�X�>���ẅ́�"ꥻ°Ա}"I%�E�x�7�(L����*�RSGR#\EIzF�ZI�$��̧9zJ��T����!zpq&Q�o�ke��9�������i&�W�|��RpNF�f���$�jN�T��'����[��tB���~ ���������H�D���fIZ �!�L�07-UQ�?":/3�+��⃒�}j��rrvc��0�*�o���O�=������Z��g�4D��O�nTQ7t�	���:���������ﱚ��u&�XD��|kMd���c�9�U�� �_z ���͇��s��Dp�L��@+4D����5�+�ʨ��dӓ��fnPx�['{�4L6�؃�8 I5�H�������EE��"�r|���&�Z�2C8x�����&��e�O�[Y�k��eΟ�0#QM�U-<+#n 7��6$����yk�!J�rd�� ��ߴ��\fg?G�1�Q��f�w\�o-E�B�����2MN2��$������*����+@9���C�X��u7E�ܑ��(gv��JtW\5��R~�i�d���/w1�w��
7�SP�#�k�Q% �<�<�/�e�t���We��i����Y7D�1-�<�3������n�\i))A�I�����5i� � >��P�7eY�l��7]�+��%#�C�
�Ѱ���uBAv��yŎ��h�h�M0��F�7���W�k������PG�L��p
^��{j��r <���]o�/�t�{A"����zxcIA�	��u^���s�'Ӫ���񸌻v����$8�h;�y�k�G��t��m�ۓb�2�Z��o���e���J���~��ҋ��xn>	��8HZ�B���%�E�.��vh�C���Y��RT��qeG���wЙ����x= �R��~>~q��(�<����{V	|��]�������#� ��54��G�����E&fI	� zl� G�E==6k�=�~����iRJj�짳#�����' �����"�SBd�n����	�3�HJb$��n�DrX=!&�c�.�2�;�=��	�
4���#��!���j���X�5?P�N�x1��K�S�ș���i�9E=���q[����=�r6����(��3�	y@��'E�X���X$%F�b�`GvJ���@�s��Q0"Lԓ�ݙ�A��
���:r���d�:� q����T�ֳ4�e�!��,��V+�wP��YS�v��[���+���Eq/P<�v����:�e����&�_v�xQ�*�г1ߜ�<f�*��J ���֍�=��h]�I��A�TÃ�u{d,�&�#dGl�t�B1`�wU��al��Ma3GEzɻ.:\FaRIU����W��IYe@r>�M����ȡ��b�ɒ�!�dвe�߷�JȪ�0BO+vhя��3��*x��/�85��D��,0
){ڣ�)���/5�����(���V��!!�=�v��ށ���<�jL�R��g�?��$�� N/d�      "   �  x�-�I�1D��aB�����Ï���M�$�ۻ�S��2_
�m��^֡������v���-��գi��k���n	 �m�'K�|:����=��*-R~,�wާ��<;0�׵nm7�i\�O;����i��4�=�n�?U�*��eҊG�e]
�@Aw�E(�o�
���l�n\��+�u�8�#|z�t�;�䶃$:a��[�����,����;�s�l���7� �p�fg�x|/LKhDס�r�W�$DT<eHu>Gh�	�������nN��$���K������z�XMl�,!g����KY���0�.�l S/���:eoVbS��{���Yl�����'q|_�$T�#���ѩ���K#	R��<v���� �����8`�����pZD��<��,_z9Q"�3�9���E ��?'>b����I�"����?��&�V          �  x�]��n�6E�U_�Uv�~,�==��62�<Ȇݭx˒AI���s)�dv"�"o��U�����`E�t��ط3icX����NS��$-������4V��)���M��T�4��p��6m&e"{��KR��y��=M�D2Z���z�'cKA���!(��[�ڳT�a���[�N��t��!i$KSt�iYZ�l�8�)�q������e"�KO_����*�p8���8�ӪB��a�XA��	�v�1���V���X)�/OݐH[�J�6T����շ�6�镂ee�Q�q�,ݍ?��j;.Ü_!����ze����vWB~�,��"�i�L!�����Z�諫�-��䫺�]�B��I�o��i�j�$kM���F��/�Av|"-,kK,i���<���ѧM$�a��B��/ t��P;���SK�E �á��ld�?�-�z�v��2�jH�!N6��i(�/�T$�g�6�9�t���%M�����T�z�&���:&R}���4�	�!���1����\��f��xQ�,������VD-u@�{-��b!�	8#��Wc����В=��NP](�ou�J��$5[�0��Њc!����4�u��%;4ac�Vp�p=�N�qp�J�y���X����@�t���<�}Xm���֞�v�)�>�O�4{E�ݸb�0P���П��8T��m"���M�4� � �U�0Uk�$�g�nGh>is�J�ξI������%����Z���}4��pjsNxMp�t�B�c�<�y��Q��� �9����>�8 ��%pj��|@yV�K̡X�s|����D�r%�-= ʦ��1���淳"1'r��}w��n�s��U*fd�`�����1ݹC�i3C����<H��M����FJ��Q�wP�h�q�ׯ��/��l      #   =  x�UV[n`;�Ns�����c��H�jz(����-s�v>�b���^�-݋�oNF��L�^��a�����`d�9�\��g��e�,w1E������VFgN[�����o���߆��o4FN��@9H���%��s�7�r�g�f���/�
Y��)�^v�! fߧB^�,]xgShC�u�1n7Q��
h����!�l�5�o"̮��+*��"�1dydmi6Nc��BP���[|�K�ٲ�&�h��͖o@�������R�Ս9��ȖO�ם�O�<�Dlx/�5�R>��{cz�E�,�U{Z�2B�ł�s(#
�?�3<��0��P7Ԥ'���T��Р��|Dd��$��X�eK��f�T�b�J�Q��v����)!�-c��z�����Pl(8C��uQ�� K�#HO�2� �I��@k�0@�&�̲PH?��(|�g�Q�e��xˍ-����@oo�ڠ�Ġ	��H_�`K�
���A1�bH�gi��"h`�V[�{3+��?�'�d7�uH�
���x�lKYr�A������L��Q8l��2����邖��hJ9���b��?c|�u�n�	��ĉ�AZ�尐Y��V�1�@Dla�0H�	�[*g��@F ķ���oe��lj�M7�>X�z6%���Б��=�e�����ŵgW�����#I��������n;�0��lq{B_܄A��y	EҦ�����F`?��LkS����qX��Da9��X䷧3���&��_ˍ�ڐ�){
�}�Y�0pC�~�����Kߵ�Q
��������M��q�����-��>�"t�oo���Or�rθ=u���q��:��;�HE!��-BN�����S ��!�tUqb&W�#5�~��$���
8�?a�x��+a
�'�3����I��k�>άT��{y>���+*�%���IE�3�]Ҟ'\HLW��}��<p�a�4��n��|;IX���@�>XTZKT�
�d3�7�.�-J?��Y��:��X�$񤈈	�##���y�'�=�WZ;�k��k?�T��_���G�/     