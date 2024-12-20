USE [master]
GO
/****** Object:  Database [OnlineBookStore]    Script Date: 09-Dec-24 4:44:04 PM ******/
CREATE DATABASE [OnlineBookStore]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OnlineBookStore', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OnlineBookStore.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OnlineBookStore_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\OnlineBookStore_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [OnlineBookStore] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OnlineBookStore].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OnlineBookStore] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OnlineBookStore] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OnlineBookStore] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OnlineBookStore] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OnlineBookStore] SET ARITHABORT OFF 
GO
ALTER DATABASE [OnlineBookStore] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OnlineBookStore] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OnlineBookStore] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OnlineBookStore] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OnlineBookStore] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OnlineBookStore] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OnlineBookStore] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OnlineBookStore] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OnlineBookStore] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OnlineBookStore] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OnlineBookStore] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OnlineBookStore] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OnlineBookStore] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OnlineBookStore] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OnlineBookStore] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OnlineBookStore] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OnlineBookStore] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OnlineBookStore] SET RECOVERY FULL 
GO
ALTER DATABASE [OnlineBookStore] SET  MULTI_USER 
GO
ALTER DATABASE [OnlineBookStore] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OnlineBookStore] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OnlineBookStore] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OnlineBookStore] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OnlineBookStore] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OnlineBookStore] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'OnlineBookStore', N'ON'
GO
ALTER DATABASE [OnlineBookStore] SET QUERY_STORE = ON
GO
ALTER DATABASE [OnlineBookStore] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [OnlineBookStore]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[author_id] [smallint] IDENTITY(1,1) NOT NULL,
	[author_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Book]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[isbn] [char](13) NOT NULL,
	[title] [nvarchar](200) NOT NULL,
	[category_id] [smallint] NOT NULL,
	[author_id] [smallint] NOT NULL,
	[year_of_publication] [smallint] NOT NULL,
	[publisher_id] [smallint] NOT NULL,
	[quantity] [int] NOT NULL,
	[cover] [bit] NOT NULL,
	[price] [money] NOT NULL,
	[discount_percent] [float] NOT NULL,
	[is_discount] [bit] NOT NULL,
	[description] [nvarchar](max) NOT NULL,
	[url1] [varchar](255) NOT NULL,
	[url2] [varchar](255) NOT NULL,
	[url3] [varchar](255) NOT NULL,
	[url4] [varchar](255) NOT NULL,
	[url5] [varchar](255) NOT NULL,
	[cluster] [smallint] NULL,
	[is_discontinued] [bit] NOT NULL,
 CONSTRAINT [PK_Book] PRIMARY KEY CLUSTERED 
(
	[isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[cart_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](36) NOT NULL,
	[isbn] [char](13) NOT NULL,
	[quantity] [smallint] NOT NULL,
 CONSTRAINT [PK_Cart] PRIMARY KEY CLUSTERED 
(
	[cart_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[category_id] [smallint] IDENTITY(1,1) NOT NULL,
	[category_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[History]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](36) NOT NULL,
	[request_time] [datetime] NOT NULL,
	[session_id] [nvarchar](50) NOT NULL,
	[isbn] [char](13) NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDetail]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetail](
	[order_detail_id] [bigint] IDENTITY(1,1) NOT NULL,
	[order_id] [bigint] NOT NULL,
	[isbn] [char](13) NOT NULL,
	[quantity] [smallint] NOT NULL,
	[price] [money] NOT NULL,
 CONSTRAINT [PK_OrderDetail_1] PRIMARY KEY CLUSTERED 
(
	[order_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[order_id] [bigint] IDENTITY(1,1) NOT NULL,
	[user_id] [varchar](36) NOT NULL,
	[promotion_id] [int] NOT NULL,
	[order_date] [date] NOT NULL,
	[receiver] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[payment_method] [nvarchar](50) NOT NULL,
	[order_status] [nvarchar](50) NOT NULL,
	[total_price] [money] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[promotion_id] [int] IDENTITY(1,1) NOT NULL,
	[promotion_name] [nvarchar](100) NOT NULL,
	[start_date] [date] NOT NULL,
	[end_date] [date] NOT NULL,
	[condition] [money] NOT NULL,
	[discount_percent] [float] NOT NULL,
 CONSTRAINT [PK_Promotion] PRIMARY KEY CLUSTERED 
(
	[promotion_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Publisher]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Publisher](
	[publisher_id] [smallint] IDENTITY(1,1) NOT NULL,
	[publisher_name] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Publisher] PRIMARY KEY CLUSTERED 
(
	[publisher_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[user_id] [varchar](36) NOT NULL,
	[isbn] [char](13) NOT NULL,
	[rating] [smallint] NOT NULL,
 CONSTRAINT [PK_Rating] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[role_id] [varchar](5) NOT NULL,
	[role_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_MasterRole] PRIMARY KEY CLUSTERED 
(
	[role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SatisfyProduct]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SatisfyProduct](
	[history_id] [int] NOT NULL,
	[isbn] [char](13) NOT NULL,
 CONSTRAINT [PK_SatisfyProduct] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC,
	[isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[staff_id] [varchar](36) NOT NULL,
	[full_name] [nvarchar](60) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[phone] [char](10) NOT NULL,
	[id_card] [char](12) NOT NULL,
	[role_id] [varchar](5) NOT NULL,
	[gender] [bit] NOT NULL,
	[birthday] [date] NOT NULL,
	[address] [nvarchar](100) NOT NULL,
	[pwd] [char](60) NOT NULL,
	[is_active] [bit] NOT NULL,
	[is_quit] [bit] NOT NULL,
 CONSTRAINT [PK_StaffAccount] PRIMARY KEY CLUSTERED 
(
	[staff_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 09-Dec-24 4:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[user_id] [varchar](36) NOT NULL,
	[email] [varchar](50) NOT NULL,
	[full_name] [nvarchar](60) NOT NULL,
	[gender] [bit] NOT NULL,
	[birthday] [date] NOT NULL,
	[pwd] [char](60) NOT NULL,
	[address] [nvarchar](max) NOT NULL,
	[is_active] [bit] NOT NULL,
	[phone] [varchar](10) NOT NULL,
 CONSTRAINT [PK_UserAccount] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Author] ON 

INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (21, N'Dale Carnegie')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (17, N'Eiichiro Oda')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (15, N'Fujiko F Fujio')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (5, N'Kim Lân')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (4, N'Nam Cao')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (3, N'Ngô Tất Tố')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (10, N'Nguyễn Công Hoan')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (1, N'Nguyễn Nhật Ánh')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (13, N'Paulo Coelho
')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (7, N'Thạch Lam')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (20, N'Thiên Phúc')
INSERT [dbo].[Author] ([author_id], [author_name]) VALUES (14, N'Tony buổi sáng')
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8794069305344', N'"Chém" Tiếng Anh ', 5, 20, 2024, 2, 996, 0, 150000.0000, 0.3, 1, N'Đây là cuốn sách giúp nâng cao tiếng anh', N'8794069305344_1_BDC1-5.jpg', N'8794069305344_2_BDC-3.jpg', N'8794069305344_3_BDC-4.jpg', N'8794069305344_4_BDC-5.jpg', N'8794069305344_5_chemta-bino_bia1.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974148715', N'Nguyễn Nhật Ánh Trong Mắt Đồng Nghiệp', 4, 1, 2017, 4, 55, 1, 135000.0000, 0.25, 1, N'Nguyễn Nhật Ánh Trong Mắt Đồng Nghiệp

Nhà văn có lẽ  không thể hạnh phúc hơn  khi được cả 3 đối tượng Bạn đọc, Nhà phê bình, và Bạn Văn đánh giá cao, dành tình cảm cho tác phẩm của mình.  

Đã từng có  Nguyễn Nhật Ánh- hoàng tử bé của tuổi thơ (NXB Kim Đồng 2012) viết về quá trình sáng tác của nhà văn, Nguyễn Nhật Ánh và tôi, ( NXB Trẻ 2013) mang tình cảm bạn đọc dành cho nhà văn và tác phẩm từ cuộc thi cùng tên,  Nguyễn Nhật Ánh - Hiệp sĩ của tuổi thơ"(Nxb Đại học Quốc gia, 2015) là những soi chiếu, đánh giá của giới nghiên cứu phê bình mang tính học thuật.

Trong cuốn sách này, tác giả là các bạn văn, bạn thơ, nhà báo, những người yêu mến ông, đồng hương và bạn bè khắp trong nước và nước ngoài của ông,  các nhà nghiên cứu phê bình, nhà giáo dục, nhạc sĩ, đạo diễn,  một số nhà báo, dịch giả nước ngoài …

Theo các bài viết được sắp xếp theo thứ tự thời gian, có thể thấy một hành trình nỗ lực không ngừng trong bút pháp, phát triển đa dạng đề tài. Sau bộ sách 23 cuốn và bộ Kính vạn hoa, Nguyễn Nhật Ánh bắt đầu đổi khác từ Tôi là Bêtô, Cho tôi xin một vé đi tuổi thơ, Lá nằm trong lá, Tôi thấy hoa vàng trên cỏ xanh, Ngồi khóc trên cây…Ngay cả truyện đồng thoại của ông (Có 2 con mèo ngồi bên cửa sổ, Chúc một ngày tốt lành) cũng khác một cách đặc biệt về thể loại.', N'NNA2-1.jpg', N'NNA2-2.jpg', N'NNA2-3.jpg', N'NNA2-4.jpg', N'NNA2-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974151647', N'Cây Chuối Non Đi Giày Xanh (Bìa Cứng)
', 4, 1, 2018, 4, 85, 1, 220000.0000, 0.17, 1, N'Cây Chuối Non Đi Giày Xanh (Bìa Cứng)

Trích "Cây Chuối Non Đi Giày Xanh"
"Khác với mùa thu rón rén, bao giờ mùa hè cũng về với những bước chân rộn ràng. Cây phượng trước sân trường tôi và cây phượng trước sân chùa Giác Nguyên thi nhau nở đỏ thắm mấy hôm nay. Trên những ngọn cây cao hai bên bờ suối, tiếng ve đã bắt đầu râm ran. Và trên cánh đồng dẫn vô con suối xóm Trong, cỏ khô đi dưới cái nắng như thiêu, rủ nhau chuyển sang màu rơm rạ và phát ra tiếng kêu lạo xạo mỗi khi bánh xe của chú tiểu Khôi lăn qua.

....

Khi người ta lớn lên, niềm vui và nỗi buồn cũng lớn lên theo. Trong những giấc mơ của tôi, không có châu chấu chuồn chuồn như những ngày thơ bé. Đã có bão giông theo về trong những đêm gió luồn qua mái lá. Ờ, ngay cả giấc mơ cũng lớn lên đó thôi."', N'NNA10-1.jpg', N'NNA10-2.jpg', N'NNA10-3.jpg', N'NNA10-4.jpg', N'NNA10-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974158721', N'Cảm Ơn Người Lớn (Bìa Cứng)
', 4, 1, 2018, 4, 55, 1, 220000.0000, 0.2, 1, N'Cảm Ơn Người Lớn (Bìa Cứng)

Cảm ơn người lớn - một áng văn lãng mạn trong giọng hài hước đặc biệt “dành cho trẻ em, và những ai từng là trẻ em”..

Bạn sẽ gặp lại Mùi, Tủn, Tí sún, Hải cò… của Cho tôi xin một vé đi tuổi thơ, cùng chơi những trò chơi quen thuộc, và được đắm mình vào những ước mơ điên rồ, ngốc nghếch nhưng trong veo của tuổi mới lớn hồn nhiên và đầy ắp dự định.

Và cả khi họ đã trưởng thành, bạo chúa thời gian đã vùng vẫy thế nào trong cuộc đời của những nhân vật mà bạn yêu quý…Hãy bắt đầu đọc từ bất cứ trang nào, có thể đọc bất cứ lúc nào, và cùng với bất cứ ai. Bạn sẽ nhận được món quà “n trong 1” của nhà văn Nguyễn Nhật Ánh: sẽ n lần thổn thức qua 1 cuốn sách 19 chương đầy ắp tình bạn ngây thơ, tình xóm giềng tốt lành nhân ái, tình yêu đắm đuối ngọt ngào…
Cảm ơn người lớn được Nguyễn Nhật Ánh đặt bút viết đúng sau 10 năm ra đời Cho tôi xin một vé đi tuổi thơ – cuốn sách bán chạy tới nay đã 400.000 bản.', N'NNA9-1.jpg', N'NNA9-2.jpg', N'NNA9-3.jpg', N'NNA9-4.jpg', N'NNA9-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974160328', N'Combo Chúc Một Ngày Tốt Lành + Cảm Ơn Người Lớn (Bộ 2 Cuốn)', 4, 1, 2020, 4, 26, 1, 225000.0000, 0.16, 1, N'Combo Chúc Một Ngày Tốt Lành + Cảm Ơn Người Lớn (Bộ 2 Cuốn)

1. Chúc Một Ngày Tốt Lành

Đọc tựa cuốn sách mới nhất của nhà văn Nguyễn Nhật Ánh là muốn mở ngay trang sách. Bạn sẽ thấy một thứ ngôn ngữ lạ của Hàn Quốc hay của nước nào tùy bạn

đoán, Gô un un là Chào buổi sáng; Un gô gô là Chúc ngủ ngon, và nữa, Chiếp un un; Ăng gô gô; Chiếp chiếp gô…

Sau chó Bê Tô, rồi Hai con mèo ngồi bên cửa sổ, nhà văn viết về một cặp heo

Nhân vật chính là hai con heo con, Lọ Nồi thông minh và Đeo Nơ xinh đẹp, cùng bạn chó Mõm Ngắn con chị Vện, mẹ Nái Sề, anh Đuôi Xoăn, Cánh Cụt và bọn gà chíp

nhà chị Mái Hoa,… đã làm nên một câu chuyện vô cùng thú vị..

Và thế giới trở nên thay đổi!

2. Cảm Ơn Người Lớn

“Tôi viết cuốn sách này không dành cho trẻ em. Tôi viết cho những ai từng là trẻ em.”  (CHO TÔI XIN MỘT VÉ ĐI TUỔI THỚ)

---o0o---

So với trẻ con, người lớn luôn cảm thấy thiếu thốn và luôn cảm thấy đau khổ. “Ôi, đời tôi sao khổ thế này!” - đó là câu người lớn hay than, từ người không đủ tiền mua

một tấm áo đến người thiếu một khoản tiền nhỏ để có thể mua một ngôi nhà lớn.

Trẻ con không bao giờ than như thế, vì bọn tôi cả đời chỉ cần đủ tiền mua bánh kẹo, cà rem, xi-rô, ổi xoài (tất nhiên cuộc đời trẻ con chỉ kéo dài đến chừng nào trở thành

người lớn). Đang đói bụng mà có tiền mua một ổ bánh mì là cuộc sống bọn tôi lập tức biến thành màu hồng dù trước đó nó được vẽ bằng gam màu nhem nhuốc gì đi

nữa.

Tóm lại, trẻ con chẳng có mơ ước gì cao xa. Nhờ vậy bọn trẻ không có nhiều khổ não, thất vọng hay bất đắc chí như người lớn. Người lớn cũng biết thế nên họ tự đặt

ra các câu danh ngôn để tự răn mình. Lớn lên tôi đọc được câu “tri túc tiện túc đãi túc hà thời túc” – “biết đủ thì ắt thấy đủ, còn đợi cho đủ sẽ chẳng bao giờ thấy đủ”.

Câu nói rất hay (người lớn bao giờ cũng nói hay) nhưng sau khi gật gù khen hay, người lớn thường làm ngược lại.

(CẢM ỚN NGƯỜI LỚN)', N'NNA5.jpg', N'NNA5.jpg', N'NNA5.jpg', N'NNA5.jpg', N'NNA5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974162155', N'Thương Nhớ Trà Long (Tái Bản 2019)', 4, 1, 2019, 4, 49, 1, 70000.0000, 0.18, 1, N'Một cuốn sách lãng mạn, trong từng con chữ đầy ắp tình yêu với mưa, với lá, với ngôi nhà cũ, cuốn sách xưa, cùng nỗi nhớ quê và những kỷ niệm thuở nhỏ... Có thể thấy mùi vị của những món ăn mẹ nấu, màu sắc trái cây mẹ mua, những trò chơi của con nhà nghèo…, từ ký ức tác giả đã vẽ ra cho người đọc cả một miền quê với hình ảnh, bối cảnh, không gian, con người của thời ấy, chân thực và tinh tế.', N'NNA8-1.jpg', N'NNA8-2.jpg', N'NNA8-3.jpg', N'NNA8-4.jpg', N'NNA8-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974164135', N'Làm Bạn Với Bầu Trời - Tặng Kèm Khung Hình Xinh Xắn', 4, 1, 2019, 4, 247, 1, 110000.0000, 0.16, 1, N'Làm Bạn Với Bầu Trời

Một câu chuyện giản dị, chứa đầy bất ngờ cho tới trang cuối cùng. Và đẹp lộng lẫy, vì lòng vị tha và tình yêu thương, khiến mắt rưng rưng vì một nỗi mừng vui hân hoan. Cuốn sách như một đốm lửa thắp lên lòng khát khao sống tốt trên đời.

Viết về điều tốt đã không dễ, viết sao cho người đọc có thể đón nhận đầy cảm xúc tích cực, và muốn được hưởng, được làm những điều tốt dù nhỏ bé... mới thật là khó. Làm bạn với bầu trời của Nguyễn Nhật Ánh đã làm được điều này.

Như nhà văn từng phát biểu “...điểm mạnh của văn chương nằm ở khả năng thẩm thấu. Bằng hình thức đặc thù của mình, văn chương góp phần mài sắc các ý niệm đạo đức nơi người đọc một cách vô hình. Bồi đắp tâm hồn và nhân cách một cách âm thầm và bền bỉ, đó là chức năng gốc rễ của văn chương, đặc biệt là văn chương viết cho thanh thiếu niên.”', N'NNA7-1.JPG', N'NNA7-2.JPG', N'NNA7-3.JPG', N'NNA7-4.JPG', N'NNA7-5.JPG', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974165941', N'Người Quảng Đi Ăn Mì Quảng (Tái Bản 2020)', 4, 1, 2020, 4, 100, 1, 75000.0000, 0.12, 1, N'Mô tả sản phẩm
“Tạp văn của Nguyễn Nhật Ánh không chỉ luận bàn về mì Quảng. Anh nói đủ mọi thứ trên trời dưới bể. Từ món ăn đến thư pháp, từ sân khấu đến điện ảnh, từ chuyện ở nhà đến chuyện cơ quan, từ chuyện siêu thị đến chuyện phố xá, từ chuyện Sài Gòn đến chuyện miền Tây... Anh luận bàn đủ thứ: từ lớn đến nhỏ, từ đồ giả đến cuộc náo loạn Hollywood, từ quạt Cophaco đến quạt Ba Tiêu... Anh cũng thích đủ mọi thứ: từ thú đọc quảng cáo đến nghe cải lương bên sông Tiền, từ xem bóng đá đến ngắm hoa đào trong tranh, rồi “chat”... Rồi buồn và nuối tiếc những kỷ niệm xưa như Chia tay buổi chiều, Sách của một thời, Buồn gì đâu...

Anh trò chuyện với đủ mọi người: từ gã họ Đỗ ở báo Sài Gòn Tiếp Thị đến các bạn đọc nhí của tờ Mực Tím, từ chị trông giữ xe đến những người hàng xóm, bà cụ bán nước, từ cô con gái nhỏ trong nhà đến những em bé chẳng hề quen... lang thang trong những kiếp người... Đọc hết, mới thấy một Nguyễn Nhật Ánh thật ân tình và tỉ mỉ. Hóa ra những cuộc trò chuyện của anh cứ tưởng là tầm phào thế mà đầy triết lý. Anh không bàng quan, không thờ ơ với cuộc sống mà nặng lòng với hết thảy. Sau mỗi cuộc chuyện trò, cho dù đó là cuộc gặp gỡ ngẫu nhiên, bao giờ anh cũng phát hiện ra một điều gì đấy - cái điều mà chính anh cũng thấy bất ngờ, thú vị.', N'NNA6-1.jpg', N'NNA6-2.jpg', N'NNA6-3.jpg', N'NNA6-4.jpg', N'NNA6-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974166122', N'Con Chó Nhỏ Mang Giỏ Hoa Hồng (Tái Bản 2020)', 4, 1, 2020, 4, 60, 1, 95000.0000, 0.16, 1, N'Cái tựa sách quả là có sức gợi tò mò.

Tại sao lại là con chó mang giỏ hoa hồng? Nó mang cho bạn nó, hay cho những ai biết yêu thương nó?  

Câu chuyện về 5 chú chó đầy thú vị và cũng không kém cảm xúc lãng mạn- tác phẩm mới nhất của nhà văn bestseller Nguyễn Nhật Ánh sẽ khiến bạn thay đổi nhiều trong cách nhìn về loài thú cưng số 1 thế giới này.', N'NNA4-1.JPG', N'NNA4-2.JPG', N'NNA4-3.JPG', N'NNA4-4.JPG', N'NNA4-5.JPG', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974176428', N'Lá Nằm Trong Lá - Tái Bản 2022', 4, 1, 2022, 4, 759, 0, 100000.0000, 0.16, 1, N'Chuyện của bút nhóm học trò, truyện nằm trong truyện, những cơn giận dỗi ghen tuông bạn gái bạn trai với nhau, nhiều nhất vẫn là chuyện nhà trường có các cô giáo hơn trò vài tuổi coi trò như bạn, có thầy hiệu trưởng tâm lý và yêu thương học trò coi trò như con…Trở lại với đề tài học trò, hóm hỉnh và gần gũi như chính các em, Nguyễn Nhật Ánh chắc chắn sẽ được các bạn trẻ vui mừng đón nhận. Cứ lật đằng cuối sách, đọc bài thơ tình trong veo là có thể thấy điều đó “…Khi mùa xuân đến / Tình anh lại đầy / Lá nằm trong lá / Tay nằm trong tay”
 
“Viết cho trẻ con giờ khó hơn xưa. Có hàng bao nhiêu là món giải trí rầm rộ, hoành tráng và lộng lẫy dọn sẵn, muốn thu phục “lũ tiểu yêu” thế kỷ 21 này, nhà văn không chỉ thông thuộc mặt bằng hiểu biết của chúng, mà còn phải tâm tình được với chúng bằng tốc độ của chúng. Có thể nói Nguyễn Nhật Ánh là một người lớn chấp nhận tham dự món du hành tốc độ cao cùng lũ trẻ. Thời thong thả đạp xe, từ tốn khuyên bảo đã qua rồi. Thực ra Nguyễn Nhật Ánh đã biết đi tàu tốc hành từ hai thập niên trước, khi nhữngKính vạn hoa, Thằng quỷ nhỏ, Bàn có năm chỗ ngồi… đem lại cho văn học thiếu nhi một diện mạo mới mẻ, những câu chuyện tưởng như ấm ớ ngày này qua tháng khác nhưng sao hôm nay nhìn lại, những người đã từng là trẻ con thấy nhớ quá..” (VIỆT TRUNG, báo Thanh Niên)
“Bước vào khoảng trời của tuổi biết buồn, Nguyễn Nhật Ánh đã ghi lại những bâng khuâng rung cảm đầu đời. Trong tâm tưởng của các em, bây giờ không chỉ nghĩ về cái gì mà còn nghĩ về ai, về một người khác giới cụ thể nào, và về cả bản thân, thế giới ấy tràn ngập những câu hỏi xôn xao về cái-gọi-là-tình-yêu. Truyện của Nguyễn Nhật Ánh đã đưa vào những câu hỏi lớn, muôn thuở, quen thuộc - những câu hỏi mà dường như trong đời ai cũng từng đối diện ít nhất một lần. Vì thế, trong khi độc giả thiếu niên phục lăn vì nhà văn đi guốc vào bụng họ, thì độc giả người lớn mỉm cười mơ màng nhớ lại một thời thơ dại..." (TS. NGUYỄN THỊ THANH XUÂN, nhà nghiên cứu văn học)', N'NNA1-1.jpg', N'NNA1-2.jpg', N'NNA1-3.jpg', N'NNA1-4.jpg', N'NNA1-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974178859', N'Thời Thơ Ấu Dài Lâu - Nguyễn Nhật Ánh - Boxset 24 Cuốn - Phiên Bản Tươi Mới', 4, 1, 2022, 4, 75, 1, 2456000.0000, 0.17, 1, N'Thời Thơ Ấu Dài Lâu - Nguyễn Nhật Ánh - Boxset 24 Cuốn - Phiên Bản Tươi Mới

Boxset 24 cuốn - Thời thơ ấu dài lâu sẽ là quà tặng xứng đáng dành cho các bạn đọc yêu quý với phiên bản:

Phiên bản tươi mới với hộp xanh ngọc ngọt ngào, khổ sách 13x20cm, bìa sách được thiết kế đa sắc theo xu hướng hiện đại.

Ở mặt ngoài boxset của 2 phiên bản có tranh minh hoạ của hoạ sĩ Đỗ Hoàng Tường; bài thơ vui của nhà nghiên cứu phê bình văn học nổi tiếng Phạm Xuân Nguyên làm từ 24 tựa của bộ sách này.', N'NNA3.jpg', N'NNA3.jpg', N'NNA3.jpg', N'NNA3.jpg', N'NNA3.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974179978', N'Combo Sách Trên Đường Băng + Cà Phê Cùng Tony + 13 Nguyên Tắc Nghĩ Giàu Làm Giàu (Bộ 3 Cuốn)', 5, 14, 2022, 2, 79, 1, 400000.0000, 0.19, 1, N'Combo Sách Trên Đường Băng + Cà Phê Cùng Tony + 13 Nguyên Tắc Nghĩ Giàu Làm Giàu (Bộ 3 Cuốn)

1. Trên Đường Băng

TRÊN ĐƯỜNG BĂNG là cuốn sách tập hợp những bài viết truyền cảm hứng và hướng dẫn kỹ năng cho các bạn trẻ khi chuẩn bị bước vào đời.

2. Cà Phê Cùng Tony

Tập bài viết truyền cảm hứng của tác giả Tony Buổi Sáng gửi cho các bạn trẻ. Những câu chuyện đời, chuyện làm người, lập nghiệp... kể bằng giọng văn trào phúng.

3. 13 Nguyên Tắc Nghĩ Giàu Làm Giàu - Think And Grow Rich

Cuốn sách sẽ giúp bạn trở nên giàu có, làm giàu cho cuộc sống của bạn trên tất cả các phương diện của cuộc sống chứ không chỉ về tài chính và vật chất.', N'TN3-1.jpg', N'TN3-2.jpg', N'TN3-3.jpg', N'TN3-4.jpg', N'TN3-1.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974179979', N'Combo Sách Cà Phê Cùng Tony + Trên Đường Băng (Bộ 2 Cuốn)', 5, 14, 2022, 2, 46, 1, 350000.0000, 0.3, 1, N'Combo Sách Cà Phê Cùng Tony + Trên Đường Băng (Bộ 2 Cuốn)

1. Cà Phê Cùng Tony

Tập bài viết truyền cảm hứng của tác giả Tony Buổi Sáng gửi cho các bạn trẻ. Những câu chuyện đời, chuyện làm người, lập nghiệp... kể bằng giọng văn trào phúng.

2. Trên Đường Băng

TRÊN ĐƯỜNG BĂNG là cuốn sách tập hợp những bài viết truyền cảm hứng và hướng dẫn kỹ năng cho các bạn trẻ khi chuẩn bị bước vào đời.', N'TN2.jpg', N'TN2.jpg', N'TN2.jpg', N'TN2.jpg', N'TN2.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974180548', N'Cà Phê Cùng Tony (Tái Bản 2022)', 5, 14, 2022, 2, 84, 0, 150000.0000, 0.25, 1, N'Tập bài viết truyền cảm hứng của tác giả Tony Buổi Sáng gửi cho các bạn trẻ. Những câu chuyện đời, chuyện làm người, lập nghiệp... kể bằng giọng văn trào phúng.', N'TN1-1.jpg', N'TN1-2.jpg', N'TN1-3.jpg', N'TN1-4.jpg', N'TN1-5.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8934974182238', N'Bộ Sách Trò Chuyện Cùng Tony (Tái Bản) (Bộ 2 Cuốn)', 5, 14, 2022, 2, 78, 0, 300000.0000, 0.24, 1, N'Cà phê cùng Tony

Có đôi khi vào những tháng năm bắt đầu vào đời, giữa vô vàn ngả rẽ và lời khuyên, khi rất nhiều dự định mà thiếu đôi phần định hướng, thì CẢM HỨNG là điều quan trọng để bạn trẻ bắt đầu bước chân đầu tiên trên con đường theo đuổi giấc mơ của mình.

Cà phê cùng Tony là tập hợp những bài viết của tác giả Tony Buổi Sáng. Đúng như tên gọi, mỗi bài nhẹ nhàng như một tách cà phê, mà bạn trẻ có thể nhận ra một chút gì của chính mình hay bạn bè mình trong đó: Từ chuyện lớn như định vị bản thân giữa bạn bè quốc tế, cho đến chuyện nhỏ như nên chú ý những phép tắc xã giao thông thường. Chúng tôi tin rằng những người trẻ tuổi luôn mang trong mình khát khao vươn lên và tấm lòng hướng thiện, và có nhiều cách để động viên họ biến điều đó thành hành động. Nếu như tập sách nhỏ này có thể khơi gợi trong lòng bạn đọc trẻ một cảm hứng tốt đẹp, như tách cà phê thơm vào đầu ngày nắng mới, thì đó là niềm vui lớn của NXB Trẻ và tác giả Tony Buổi Sáng.', N'TN1.jpg', N'TN1.jpg', N'TN1.jpg', N'TN1.jpg', N'TN1.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935088549429', N'Vợ Nhặt', 8, 5, 1990, 5, 0, 1, 49000.0000, 0.23, 1, N'Kim Lân tên thật là Nguyễn Văn Tài (1921-2007), quê gốc: Thôn Phù Lưu, xã Tân Hồng, huyện Tiên Sơn, tỉnh Bắc Ninh. Đảng viên Đảng Cộng sản Việt Nam. Hội viên sáng lập Hội Nhà văn Việt Nam (1957). Nhà văn Kim Lân tham gia văn hóa Cứu quốc, trong kháng chiến chống Pháp công tác ở chiến khu Việt Bắc. Ông Từng là ủy viên Ban phụ trách Nhà xuất bản Văn học, trường bồi dưỡng những người viết trẻ, Tuần báo Văn nghệ, Nhà xuất bản Tác phẩm mới. Ông nhận Giải thưởng Nhà nước về Văn học Nghệ thuật năm 2000.

Tập truyện ngắn Vợ nhặt tập hợp những truyện ngắn đặc sắc nhất của Kim Lân – một cây bút truyện ngắn vững vàng, viết về cuộc sống và con người ở nông thôn bằng tình cảm, tâm hồn của một người vốn là con đẻ của đồng ruộng.', N'Vn.jpg', N'Vn.jpg', N'Vn.jpg', N'Vn.jpg', N'Vn.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935095626793', N'Nguyễn Công Hoan - Truyện Ngắn Hay Chọn Lọc
', 8, 10, 2018, 5, 15, 0, 110000.0000, 0.21, 1, N'Nguyễn Công Hoan - Truyện Ngắn Hay Chọn Lọc

Nguyễn Công Hoan thích bốp chát, đánh vỗ ngay vào mặt đối phương. Tiếng cười đả kích của Nguyễn Công Hoan thường là những đòn đơn giản mà ác liệt. Mỗi truyện ngắn của Nguyễn Công Hoan có một chủ đề rõ ràng, đơn giản... gắn được với một mâu thuẫn trào phúng và một tình thế hài hước. - Giáo sư Nguyễn Đăng Mạnh', N'TNHCL-1.jpg', N'TNHCL-2.jpg', N'TNHCL-3.jpg', N'TNHCL-4.jpg', N'TNHCL-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935212340762', N'Vợ Nhặt (Tái Bản 2018)', 8, 5, 2018, 5, 0, 1, 55000.0000, 0.23, 1, N'Tác phẩm "Vợ Nhặt" của tác giả Kim Lân (1921-2007). Ông là một trong những cây bút viết truyện ngắn xuất sắc nhất của văn học Việt Nam hiện đại. Với “Vợ Nhặt”, tác giả viết về cái đói, khi đói người ta thường khổ cực và chỉ muốn chết. Nhưng không, khi đói người ta không nghĩ đến con đường chết mà chỉ nghĩ đến con đường sống. Dù ở trong tình huống bi thảm đến đâu, dù kề cận cái chết vẫn khát khao được sống, được hạnh phúc, vẫn hướng về ánh sáng, vẫn tin vào sự sống và hy vọng ở tương lai, vẫn muốn sống, sống cho ra người... Chúng ta có thể thấy được điều này ở các nhân vật trong tập truyện ngắn này.

Mời các bạn đón đọc!', N'VN2018-1.jpg', N'VN2018-2.jpg', N'VN2018-3.jpg', N'VN2018-4.jpg', N'VN2018-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935212366502', N'Tắt Đèn (Tái Bản 2024)', 8, 3, 2024, 5, 60, 1, 55000.0000, 0.3, 1, N'"Theo tôi tiên tri, thì cuốn Tắt đèn còn phải sống lâu thọ hơn cả một số văn gia đương kim hôm nay. Chị Dậu, đích là tác giả Ngô Tất Tố hóa thân ra mà thôi. Chị Dậu là cái đốm sáng đặc biệt của Tắt đèn. Nếu ví toàn truyện Tắt đèn là một khóm cây thì chị Dậu là cả gốc cả ngọn cả cành, và chính chị Dậu đã nổi gió lên mà rung cho cả cái cây dạ hương Tắt đèn đó lên." (Nguyễn Tuân) "Chị Dậu là nhân vật điển hình được người đọc yêu mến. Và người yêu mến chị hơn cả là Ngô Tất Tố. Giữa biết bao tệ nạn và cảnh đời bất công ngang trái ở nông thôn Việt Nam cũ, Ngô Tất Tố đã hết lòng bảo vệ một người phụ nữ là chị Dậu. Nhiều lần chị Dậu bị đẩy vào tình thế hiểm nghèo, rất có thể bị làm nhục nhưng Ngô Tất Tố đã bảo đảm cho chị Dậu được bảo đảm an toàn phẩm toàn vẹn, giữ trọn phẩm giá, không phải đau đớn. dằn vặt." (Hà Minh Đức)', N'TD2-1.jpg', N'TD2-2.jpg', N'TD2-3.jpg', N'TD2-1.jpg', N'TD2-1.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935212366526', N'Bước Đường Cùng (Tái Bản 2024)', 8, 10, 2024, 2, 47, 0, 68000.0000, 0.23, 1, N'Bước Đường Cùng

Nguyễn Công Hoan là nhà văn viết sớm và viết nhiều và vinh dự là người đi tiên phong của trào lưu văn học hiện thực phê phán. Truyện dài có ngót hai chục tác phẩm. Truyện ngắn phải tính đến hàng trăm. Với một số lượng khá lớn như vậy, truyện ngắn của Nguyễn Công Hoan họp lại thành một bức tranh rộng lớn, khá đầy đủ về xã hội cũ. Về nghệ thuật viết truyện ngắn, phải nói rằng Nguyễn Công Hoan là người có nhiều khả năng và kinh nghiệm. Truyện của ông thường rất ngắn. Lời văn khúc triết, giản dị. Cốt truyện được dẫn dắt một cách có nghệ thuật và kết cục thường rất đột ngột để hấp dẫn người đọc. Mỗi truyện như một màn kịch ngắn có giới thiệu, thắt nút và mở nút. Tiêu biểu là các truyện ngắn: Kép Tư bền, Người ngựa, ngựa người..., tiểu thuyết có Bước đường cùng... Ngay từ khi xuất hiện, Nguyễn Công Hoan luôn gây được sự chú ý, quan tâm của giới nghiên cứu, phê bình và nhiều thế hệ độc giả. Mặc dù có nhiều người khen kẻ chê, nhưng truyện ngắn truyện dài của Nguyễn Công Hoan sừng sững tạo thành một thế Tam Đảo, Ba Vì hùng vĩ (Tô Hoài)', N'BDC1-1.jpg', N'BDC1-2.jpg', N'BDC1-3.jpg', N'BDC1-4.jpg', N'BDC1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935235226272', N'Nhà Giả Kim (Tái Bản 2020)', 6, 13, 2020, 4, 65, 0, 79000.0000, 0.18, 1, N'Tất cả những trải nghiệm trong chuyến phiêu du theo đuổi vận mệnh của mình đã giúp Santiago thấu hiểu được ý nghĩa sâu xa nhất của hạnh phúc, hòa hợp với vũ trụ và con người. 

Tiểu thuyết Nhà giả kim của Paulo Coelho như một câu chuyện cổ tích giản dị, nhân ái, giàu chất thơ, thấm đẫm những minh triết huyền bí của phương Đông. Trong lần xuất bản đầu tiên tại Brazil vào năm 1988, sách chỉ bán được 900 bản. Nhưng, với số phận đặc biệt của cuốn sách dành cho toàn nhân loại, vượt ra ngoài biên giới quốc gia, Nhà giả kim đã làm rung động hàng triệu tâm hồn, trở thành một trong những cuốn sách bán chạy nhất mọi thời đại, và có thể làm thay đổi cuộc đời người đọc.

“Nhưng nhà luyện kim đan không quan tâm mấy đến những điều ấy. Ông đã từng thấy nhiều người đến rồi đi, trong khi ốc đảo và sa mạc vẫn là ốc đảo và sa mạc. Ông đã thấy vua chúa và kẻ ăn xin đi qua biển cát này, cái biển cát thường xuyên thay hình đổi dạng vì gió thổi nhưng vẫn mãi mãi là biển cát mà ông đã biết từ thuở nhỏ. Tuy vậy, tự đáy lòng mình, ông không thể không cảm thấy vui trước hạnh phúc của mỗi người lữ khách, sau bao ngày chỉ có cát vàng với trời xanh nay được thấy chà là xanh tươi hiện ra trước mắt. ‘Có thể Thượng đế tạo ra sa mạc chỉ để cho con người biết quý trọng cây chà là,’ ông nghĩ.”', N'PC3-1.jpg', N'PC3-2.jpg', N'PC3-3.jpg', N'PC3-4.jpg', N'PC3-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935235228481', N'Ngoại Tình (Tái Bản 2020)', 6, 13, 2020, 4, 200, 0, 100000.0000, 0.18, 1, N'"Một cuộc sống không tình yêu liệu có đáng để sống chăng?"

Ở tuổi 31, Linda có mọi thứ một người đàn bà cần để cảm thấy viên mãn: người chồng thành đạt và yêu thương cô, hai đứa con ngoan, sự nghiệp ổn định và cuộc sống vật chất đầy đủ. Nhưng sự hoàn hảo đó chỉ là vẻ bề ngoài, thâm tâm Linda phải đối diện với một nỗi sợ mơ hồ: vừa sợ chuỗi hành động lặp lại ngày này qua tháng khác, vừa sợ sự đời đổi thay bất ngờ khiến mình tay trắng.

Vậy thì NGOẠI TÌNH liệu có phải là giải pháp tốt nhất cho Linda lúc này không?

PAULO COELHO một lần nữa dùng tài năng của mình để khẳng định lời tuyên bố của chính ông "những điều đơn giản nhất là những điều giá trị nhất"', N'PC2-1.jpg', N'PC2-2.jpg', N'PC2-3.jpg', N'PC2-4.jpg', N'PC2-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935235239616', N'Bản Thảo Tìm Thấy Tại Accra', 6, 13, 2024, 4, 87, 1, 96000.0000, 0.14, 1, N'Bản Thảo Tìm Thấy Tại Accra

Vào một đêm năm 1099, Jerusalem đang đứng trước cuộc vây hãm của quân Thập tự chinh, trong sự tuyệt vọng và hỗn loạn, những con người từ mọi lứa tuổi và đức tin đã quy tụ để lắng nghe lời thông thái từ một người đàn ông Hy Lạp được biết đến với cái tên, Copt.

Thay vì sợ hãi một tương lai khó tránh, với Copt, quan trọng là phải giữ cho tri thức không bị sụp đổ chung với bức tường thành. Nhưng tri thức là gì? Đó là nhận thức về Tình yêu, về Hiến dâng, về Tinh thần, về sự sống và cái chết, về cuộc phiêu lưu của phận người trên Trái đất này. Người ta đặt câu hỏi, những câu hỏi mà họ sợ sẽ chẳng còn cơ hội được giải đáp, và Copt điềm tĩnh trả lời, mãi tới tận khi bức màn đêm đen đặc phủ xuống Jerusalem. Copt nói lời cuối cùng:

"Hãy đi bình an!"', N'PC7-1.jpg', N'PC7-2.jpg', N'PC7-3.jpg', N'PC7-4.jpg', N'PC7-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935235240483', N'Hippi - Những Kẻ Lãng Du', 6, 13, 2024, 4, 55, 1, 150000.0000, 0.2, 1, N'Hippi - Những Kẻ Lãng Du

Hippie – Những kẻ lãng du đưa ta đến với những con người hoàn toàn xa lạ, với những mục đích khác nhau nhưng cùng hướng đến vùng đất xa xôi Nepal trên con đường mòn hippie huyền thoại. Trong hành trình đó, chàng trai Brazil tên Paulo gầy gò có chòm râu dê và mái tóc dài bồng bềnh, mơ ước trở thành nhà văn đã gặp gỡ Karla, cô gái Hà Lan ở độ tuổi đôi mươi đang tìm kiếm bạn đồng hành cho chuyến đi.

Sau khi gặp nhau ở Amsterdam, cô thuyết phục Paulo cùng cô lên chiếc Xe buýt Diệu kỳ đi từ Amsterdam đến Istanbul và qua Trung Á đến Kathmandu. Khi cùng nhau bắt đầu cuộc hành trình này, Paulo và Karla đã khám phá ra mối tình đánh thức họ ở mọi phương diện, đồng thời dẫn đến những lựa chọn và quyết định sẽ định hướng cho cuộc sống của họ sau này.', N'PC8-1.jpg', N'PC8-2.jpg', N'PC8-3.jpg', N'PC8-4.jpg', N'PC8-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935236427074', N'Tuyển Tập Nam Cao - Bìa Cứng (Tái Bản 2022)', 8, 4, 2022, 5, 20, 1, 160000.0000, 0.23, 1, N'"Nam Cao đã thổi hồn trên cuốn tiểu thuyết lớn của đời mình. Người ấy, tài năng ấy đương căng đầy sức lực. Nếu còn sống, chắc chắn những mong muốn của anh sẽ thành sự thật rực rỡ Tuyển Tập Nam Cao trên một tầm xa, rất xa."

Đời văn Nam Cao không dài. Trên mười năm sáng tác ở cả hai thời kỳ trước và sau Cách mạng, Nam Cao đã để lại nhiều tác phẩm có giá trị. Thời gian trôi qua, tác phẩm của Nam Cao như càng bộc lộ thêm những phẩm chất mới, những giá trị mới. Chúng ta càng thêm yêu quý ông, một tâm hồn trung thực và cao đẹp trong cuộc đời cũng như trên trang sách; một nhà văn chiến sĩ với ý nghĩa đích thực và trọn vẹn của danh hiệu này.

Tuyển Tập Nam Cao -  Quyển sách chứa đựng những tác phẩm tâm huyết nhất của nhà văn Nam Cao.', N'TTNC.jpg', N'TTNC.jpg', N'TTNC.jpg', N'TTNC.jpg', N'TTNC.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935236427838', N'Nam Cao - Lão Hạc (Tái Bản)', 8, 4, 2000, 5, 100, 1, 55000.0000, 0.23, 1, N'Lão Hạc là một truyện ngắn của nhà văn Nam Cao được viết năm 1943. Tác phẩm được đánh giá là một trong những truyện ngắn khá tiêu biểu của dòng văn học hiện thực, nội dung truyện đã phần nào phản ánh được hiện trạng xã hội Việt Nam trong giai đoạn trước Cách mạng tháng Tám.

Lão Hạc, một người nông dân chất phác, hiền lành. Lão góa vợ và có một người con trai nhưng vì quá nghèo nên không thể lấy vợ cho người con trai của mình. Người con trai lão vì thế đã rời bỏ quê hương để đến đồn điền cao su làm ăn kiếm tiền. Lão luôn trăn trở, suy nghĩ về tương lai của đứa con. Lão sống bằng nghề làm vườn, mảnh vườn mà vợ lão đã mất bao công sức để mua về và để lại cho con trai lão. So với những người khác lúc đó, gia cảnh của lão khá đầy đủ, tuy nhiên do ốm yếu hơn hai tháng và cũng vì trận bão mà lão không có việc gì để làm. Lão đã rất dằn vặt bản thân mình khi mang một "tội lỗi" là đã nỡ tâm "lừa một con chó". Lão đã khóc rất nhiều với ông giáo (người hàng xóm thân thiết của lão).', N'LH1-1.jpg', N'LH1-2.jpg', N'LH1-3.jpg', N'LH1-4.jpg', N'LH1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935236429177', N'Lều Chõng (Tái Bản 2023)', 8, 3, 2023, 5, 48, 1, 98000.0000, 0.24, 1, N'Lều Chõng

Truyện đề cập việc ngày xưa, khi đi thi thí sinh lại phải mang theo lều, chõng, thức ăn, lặn lội xa xôi lên kinh thành. Tác giả Ngô Tất Tố viết truyện này để nói lên những oái ăm của các kỳ thi này và nêu lên sự sụp đổ tinh thần của những nho sĩ suốt đời lấy khoa cử làm con đường tiến thân nhưng lại bị hoàn toàn thất vọng.', N'LC2-1.jpg', N'LC2-2.jpg', N'LC2-3.jpg', N'LC2-4.jpg', N'LC2-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935236430135', N'Tuyển Tập Thạch Lam (Tái Bản 2023)', 8, 7, 2023, 2, 36, 0, 110000.0000, 0.23, 1, N'Tuyển Tập Thạch Lam

Thạch Lam, tên thật là Nguyễn Tường Vinh, bắt đầu hoạt động vǎn học từ 1936, là thành viên của Tự lực vǎn đoàn. Trong quãng đời vǎn chưa đầy mười nǎm, Thạch Lam đã cho xuất bản ba tập truyện ngắn: Gió lạnh đầu mùa (1937), Nắng trong vườn (1938), Sợi tóc (1942); một tiểu thuyết: Ngày mới (1939); một tập ký: Hà Nội 36 phố phường (1943); và một tập tuyển luyện: Theo dòng (1941). Nhân vật trong các tác phẩm của Thạch Lam đều có cảnh ngộ, có tâm trạng và tính cách điển hình.

Ngòi bút Thạch Lam tinh tế và trân trọng biết bao trước số phận người phụ nữ và trẻ em, nếu không thuộc lớp dưới đáy thì cũng là người ở cảnh bần hàn, hoặc đang rơi vào cảnh bần hàn, như trong Cô hàng xén, Hai đứa trẻ, Tối ba mươi.

Bên cạnh thế giới phụ nữ và trẻ em, còn phải kể đến những ông chủ gia đình - những ông bố là đồ nho thất thế, lạc lõng, không vui với thời cuộc, sống vào sự tần tảo của vợ con, không dám quyết bất cứ điều gì, suốt ngày ngồi bên cái ống điếu, ra dáng nghĩ ngợi, nhưng thật ra là không nghĩ gì... (Cô hàng xén, Hai lần chết, Ngày mới).', N'TL3-1.jpg', N'TL3-2.jpg', N'TL3-3.jpg', N'TL3-4.jpg', N'TL3-5.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935236432030', N'Danh Tác Văn Học Việt Nam - Nắng Trong Vườn (Tái Bản 2024)', 8, 7, 2024, 2, 85, 1, 156000.0000, 0.3, 1, N'Danh Tác Văn Học Việt Nam - Nắng Trong Vườn (Tái Bản 2024)

Nắng trong vườn là câu chuyện tình yêu của Bình, một chàng trai mười tám tuổi chốn Hà thành phồn hoa lấp lánh ánh đèn, luôn tươi vui, nhộn nhịp và Hậu, cô thôn nữ độ chừng mười lăm, mười sáu tuổi ở miền quê, nơi có những đồi sắn, đồi trà mênh mông sắc xanh trải dài bất tận.

Hai người đến từ hai thế giới hoàn toàn khác biệt tưởng chừng không có điểm chung ấy lại hòa cùng một nhịp thở, họ đã từng trải qua thứ xúc cảm lạ lẫm bộc phát từ trái tim để rồi có cho nhau một tình yêu thật đẹp và đắm say.', N'TL10.jpg', N'TL10.jpg', N'TL10.jpg', N'TL10.jpg', N'TL10.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935236433945', N'Kinh Dịch - Bìa Cứng (Tái Bản 2024)', 8, 3, 2024, 5, 101, 1, 285000.0000, 0.4, 1, N'Kinh Dịch Trọn Bộ - Bìa Cứng (Tái Bản 2024)

Khác với trước đây, lần này, nhân dịp tái bản lần thứ 25 Trọn bộ sách Kinh Dịch của Ngô Tất Tố, dựa trên bản sách do Nhà Mai Lĩnh in năm 1943, chúng tôi xin trân trọng giới thiệu kết quả tra cứu và tìm hiểu về công việc của Dịch giả Ngô Tất Tố, góp phần giải trình cách học Kinh Dịch”. Nói đến Kinh Dịch, nhiều thế hệ bạn đọc từ trước tới nay đều cho rằng đây là cuốn sách viết về đạo lý khó hiểu, không dễ đọc. Nếu đọc kỹ chú giải ngắn gọn của Dịch giả về Quẻ Tỉnh và Quẻ Tiết: “Tỉnh là cái giếng, là ấp làng”;“Tiết là cái dóng trên thân cây tre”, bạn đọc sẽ cảm thấy quen thuộc ngay, gần gũi ngay với Kinh Dịch mà không còn quá e ngại, quá bận tâm với áp lực và câu hỏi đâu là những đạo lý bí ẩn, cao siêu. Đọc đến Lời Kinh của hai quẻ lại càng cảm thấy không quá khó, sau khi có được ít nhiều hiểu biết ban đầu, người đọc sẽ hào hứng, thích thú tiếp tục nhập môn Dịch học.', N'KD.jpg', N'KD.jpg', N'KD.jpg', N'KD.jpg', N'KD.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244822564', N'Văn Học Trong Nhà Trường - Truyện Ngắn Nam Cao (Tái Bản 2019)', 8, 4, 2019, 5, 23, 1, 44000.0000, 0.18, 0, N'“Ngày nay, chúng ta thường hay quan tâm và luận bàn về tính hiện đại của tác phẩm văn học, về cái mới và khả năng thử thách với thời gian của chúng. Thế mà những tác phẩm của chúng ta vẫn bị cũ đi, bị người đọc lãng quên rất nhanh, không chịu được thử thách của thời gian như những cái Nam Cao đã viết ra. Vậy thì ở những tác phẩm của Nam Cao có cái gì khiến nó vẫn cứ mới mãi, được người đọc đọc mãi…”', N'TNNC1-1.jpg', N'TNNC1-2.jpg', N'TNNC1-3.jpg', N'TNNC1-4.jpg', N'TNNC1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244822595', N'Văn Học Trong Nhà Trường: Hà Nội Băm Sáu Phố Phường (Tái Bản 2019)', 8, 7, 2019, 2, 45, 0, 50000.0000, 0.25, 1, N'Tập ký “Hà Nội băm sáu phố phường” cho ta thấy biết bao chăm chút, trân trọng của Thạch Lam, trước cái đẹp được ẩn giấu và lưu giữ ở những sinh hoạt và sản phẩm bình thường của Hà Nội “nghìn năm văn vật”.

Giáo sư PHONG LÊ

Chúng tôi đều biết cái khiếu thưởng thức món ăn của Thạch Lam rất tế nhị, và chúng tôi thường nói đùa rằng: “Thạch Lam ăn có nguyên tắc, uống có lập trường, và phê bình vấn đề ăn uống với một quan niệm siêu đẳng…” Tôi không bao giờ quên cái dáng điệu ngồi rất đẹp của anh, khi anh nâng chén: cái đầu nghiêng nghiêng, cặp mắt lim dim, anh rung đùi nhắc lại một câu mà anh đã viết trong Hà Nội băm sáu phố phường: “Hãy bảo cho tôi biết bạn ăn uống ra sao, tôi sẽ nói cho bạn biết bạn là người thế nào.”', N'TL5-1.jpg', N'TL5-2.jpg', N'TL5-3.jpg', N'TL5-4.jpg', N'TL5-5.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244837964', N'Văn Học Trong Nhà Trường - Truyện Ngắn Nguyễn Công Hoan', 8, 10, 2019, 5, 74, 0, 55000.0000, 0.18, 1, N'“Nguyễn Công Hoan có một vị trí vững vàng, đầy vinh dự trong lịch sử văn học dân tộc. Ông là một trong số những nhà văn đặt nền móng cho chủ nghĩa hiện thực trong văn học Việt Nam 1930 - 1945. Ông cũng là nhà văn có đóng góp quan trọng trong việc mở đường và phát triển thể loại truyện ngắn hiện đại, đặc biệt là truyện ngắn trào phúng, đưa nó tới một tầm cao mà cho tới nay, chưa có cây bút nào sánh nổi.” (Tiến sĩ TRẦN ĐĂNG SUYỀN)

“Trong kho tàng truyện ngắn của dân tộc, Nguyễn Công Hoan đã đóng góp một khối lượng lớn và có một nghệ thuật khá điêu luyện. Đi vào thế giới truyện ngắn của Nguyễn Công Hoan, ta có cảm tưởng như bước vào một khu triển lãm phong phú, nhiều màu nhiều vẻ về những cảnh ngộ, những con người múa may, khóc cười trong xã hội cũ.” (Giáo sư PHAN CỰ ĐỆ)', N'NCH3-1.jpg', N'NCH3-2.jpg', N'NCH3-3.jpg', N'NCH3-4.jpg', N'NCH3-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244865882', N'One Piece - Tập 80 - Tuyên Ngôn Về Thời Đại Mới (Tái Bản 2022)', 1, 17, 2022, 1, 42, 0, 25000.0000, 0.02, 1, N'Vài ngày sau trận chiến... Liệu băng Mũ Rơm có thể bình an thoát khỏi Dressrosa giữa vòng vây truy kích của Hải quân như mọi lần hay không? Chưa kể sau sự kiện Doflamingo bị bắt giữ, các thế lực trên thế giới đã có sự chuyển mình rõ rệt...!!

One Piece (Vua hải tặc) bộ thuộc thể loại truyện tranh Hành động kể về một cậu bé tên Monkey D. Luffy, giong buồm ra khơi trên chuyến hành trình tìm kho báu huyền thoại One Piece và trở thành Vua hải tặc.

Để làm được điều này, cậu phải đến được tận cùng của vùng biển nguy hiểm và chết chóc nhất thế giới: Grand Line (Đại Hải Trình).', N'OnePiece10-1.jpg', N'OnePiece10-2.jpg', N'OnePiece10-3.jpg', N'OnePiece10-4.jpg', N'OnePiece10-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244865974', N'One Piece - Tập 89 - Bad End Musical (Tái Bản 2021)', 1, 17, 2021, 1, 54, 0, 35000.0000, 0.03, 1, N'Một bên, nhóm của Sanji đang gấp rút hoàn thành chiếc bánh nhằm xoa dịu chứng rối loạn của Mẹ. Bên kia, Luffy cũng đang chật vật chiến đấu với kẻ thù bất bại Katakuri!! Tất cả đều nín thờ đợi chờ giây phút quyết định của trận đấu cực hạn!!

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece9-1.jpg', N'OnePiece9-2.jpg', N'OnePiece9-3.jpg', N'OnePiece9-4.jpg', N'OnePiece9-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244865981', N'One Piece - Tập 90 - Thánh Địa Mary Geoise (Tái Bản 2022)', 1, 17, 2022, 1, 64, 0, 35000.0000, 0.025, 0, N'Cờ của băng Mũ rơm trơ trọi nổi trên mặt biển... Lẽ nào các thành viên đều đã bỏ mạng trước những đợt tấn công như vũ bão của băng Big Mom!? Phần truyện về Đảo Bánh Ngọt đầy rẫy kịch tính đã khép lại!! Bước sang phần "hội nghị Thế giới" với vô số ý đồ rất khó đoán định!!!

Những chuyến phiêu lưu trên đại dương xoay quanh "ONE PIECE" lại bắt đầu!!', N'OnePiece8-1.jpg', N'OnePiece8-2.jpg', N'OnePiece8-3.jpg', N'OnePiece8-4.jpg', N'OnePiece8-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244866032', N'One Piece - Tập 95 - “Chuyến Chu Du Của Oden” (Tái Bản 2022)', 1, 17, 2022, 1, 28, 0, 25000.0000, 0.02, 0, N'Liên minh tồi tệ nhất ra đời!! Trong lúc Kaido bắt tay với “người đàn bà quái vật”, nhóm của Luffy đã tập hợp đủ thành phần để tiến về đảo Quỷ. Đó cũng là thời điểm các thế lực trên thế giới bắt đầu lung lay…

Những chuyến phiêu lưu trên đại dương  xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece7-1.jpg', N'OnePiece7-2.jpg', N'OnePiece7-3.jpg', N'OnePiece7-4.jpg', N'OnePiece7-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244866049', N'One Piece - Tập 96 - Oden Sinh Ra Là Để Nấu Sôi (Tái Bản 2022)', 1, 17, 2022, 1, 65, 1, 30000.0000, 0.022, 0, N'Trong lúc chu du cùng với băng Hải tặc Râu Trắng, số mệnh đã sắp đặt cho Oden gặp gỡ Roger!! Liệu cuộc tương ngộ giữa hai nhân vật này sẽ đem tới những thay đổi gì cho thế giới!? Trong khi đó, nhân lúc Wano quốc vắng bóng Oden, Orochi đã âm thầm ủ mưu!?

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece5-1.jpg', N'OnePiece5-1.jpg', N'OnePiece5-1.jpg', N'OnePiece5-1.jpg', N'OnePiece5-1.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244866056', N'One Piece - Tập 97 - Thánh Kinh Của Tôi (Tái Bản 2022)', 1, 17, 2022, 1, 74, 0, 30000.0000, 0.021, 1, N'Ngay trước cuộc chinh phạt diễn ra, Kanjuro bất ngờ có động thái lạ... Chưa kể Momono suke còn bị bắt cóc... Trong lúc Kinemon và mọi người đang tuyệt vọng tràn trề, Luffy - Law - Kid bất ngờ xuất trận, mang lại nguồn sáng mới cho cả bọn!! Cả binh đoàn rồng rắn thẳng tiến về đảo Quỷ!!

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece6-1.jpg', N'OnePiece6-1.jpg', N'OnePiece6-1.jpg', N'OnePiece6-1.jpg', N'OnePiece6-1.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244868449', N'One Piece - Tập 98 - Phút Huy Hoàng Của Những Trung Thần - Bản Bìa Rời', 1, 17, 2024, 1, 40, 1, 25000.0000, 0.02, 1, N'Giữa lúc trận chiến trên đảo Quỷ căng như dây đàn, Yamato - con của Kaido - tỏ ý đứng về phía Luffy để cùng chiến đấu!? Đúng lúc này, Kaido tuyên bố sẽ tiến hành “Kế hoạch Đảo Quỷ Mới”, gieo rắc nỗi kinh hoàng cho thế giới cùng với Big Mom!!

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece3-1.jpg', N'OnePiece3-2.jpg', N'OnePiece3-3.jpg', N'OnePiece3-4.jpg', N'OnePiece3-5.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244868456', N'One Piece - Tập 99 - Luffy Mũ Rơm - Bản Bìa Áo', 1, 17, 2024, 1, 35, 0, 25000.0000, 0.02, 0, N'Sau khi được đồng đội giúp cản chân lũ quản lí, cuối cùng Luffy đã lên được sân thượng và chạm mặt Kaido!? Trong khi đó, đám lâu la bên dưới sảnh trình diễn vẫn không ngừng thách chiến… Công cuộc chinh phạt lớn chưa từng thấy tại đảo Quỷ vẫn đang nóng hơn bao giờ hết!!

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece4-1.jpg', N'OnePiece4-2.jpg', N'OnePiece4-3.jpg', N'OnePiece4-4.jpg', N'OnePiece4-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244876406', N'One Piece - Tập 100 - Haki Bá Vương - Bản Bìa Áo', 1, 17, 2024, 1, 63, 1, 25000.0000, 0.02, 0, N'Những nhân vật chủ chốt đều đã có mặt trên mái vòm, nhóm Luffy đối đầu với Kaido & Big Mom. Trước liên minh mạnh nhất thế giới, liệu có phép màu nào giúp bọn họ giành chiến thắng hay không!? Tương lai nào sẽ mở ra cho các chiến binh sau trận chiến cực hạn này!? Chỉ biết rằng đảo Quỷ vẫn không ngừng rung chuyển!!

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece2-1.jpg', N'OnePiece2-2.jpg', N'OnePiece2-3.jpg', N'OnePiece2-4.jpg', N'OnePiece2-5.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244876437', N'One Piece - Tập 101 - Siêu Sao Thượng Đài - Bản Bìa Áo', 1, 17, 2023, 1, 62, 0, 25000.0000, 0.02, 0, N'Đặt niềm tin Luffy chắc chắn sẽ hồi phục và đánh bại Kaido, đồng đội của cậu vẫn kiên cường chiến đấu với các quản lý cấp cao trong băng của hắn. Cùng lúc đó, trên mái vòm của đảo Quỷ cũng diễn ra trận chiến ân oán giữa hai cha con Yamato – Kaido!!

Những chuyến phiêu lưu trên đại dương xoay quanh “ONE PIECE” lại bắt đầu!!', N'OnePiece1-1.jpg', N'OnePiece1-2.jpg', N'OnePiece1-3.jpg', N'OnePiece1-4.jpg', N'OnePiece1-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884555', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 34 (Tái Bản 2023)', 1, 15, 2023, 1, 34, 1, 22000.0000, 0.02, 1, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 34

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon8-2.jpg', N'Doraemon8-3.jpg', N'Doraemon8-4.jpg', N'Doraemon8-5.jpg', N'Doraemon8-1.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884562', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 35 (Tái Bản 2023)', 1, 15, 2023, 1, 23, 0, 22000.0000, 0.02, 1, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 35

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon6-1.jpg', N'Doraemon6-2.jpg', N'Doraemon6-3.jpg', N'Doraemon6-4.jpg', N'Doraemon6-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884586', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 37 (Tái Bản 2023)', 1, 15, 2023, 1, 12, 0, 22000.0000, 0.02, 1, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 37

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon10-1.jpg', N'Doraemon10-2.jpg', N'Doraemon10-3.jpg', N'Doraemon10-4.jpg', N'Doraemon10-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884609', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 39 (Tái Bản 2023)', 1, 15, 2023, 1, 43, 1, 22000.0000, 0.02, 1, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 39

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon9-1.jpg', N'Doraemon9-2.jpg', N'Doraemon9-3.jpg', N'Doraemon9-4.jpg', N'Doraemon9-5.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884616', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 40 (Tái Bản 2023)', 1, 15, 2023, 1, 11, 1, 22000.0000, 0.02, 1, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 40

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon7-1.jpg', N'Doraemon7-1.jpg', N'Doraemon7-1.jpg', N'Doraemon7-1.jpg', N'Doraemon7-1.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884630', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 42 (Tái Bản 2023)', 1, 15, 2023, 1, 11, 0, 22000.0000, 0.02, 0, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 42

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon5-1.jpg', N'Doraemon5-2.jpg', N'Doraemon5-3.jpg', N'Doraemon5-4.jpg', N'Doraemon5-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884647', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 43 (Tái Bản 2023)', 1, 15, 2023, 1, 22, 0, 23000.0000, 0.02, 0, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 43

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon3-1.jpg', N'Doraemon3-2.jpg', N'Doraemon3-3.jpg', N'Doraemon3-4.jpg', N'Doraemon3-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884654', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 44 (Tái Bản 2023)', 1, 15, 2023, 1, 33, 0, 25000.0000, 0.02, 0, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 44

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon4-1.jpg', N'Doraemon4-2.jpg', N'Doraemon4-3.jpg', N'Doraemon4-4.jpg', N'Doraemon4-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935244884661', N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 45 (Tái Bản 2023)', 1, 15, 2023, 1, 44, 0, 22000.0000, 0.02, 1, N'Doraemon - Chú Mèo Máy Đến Từ Tương Lai - Tập 45

Những câu chuyện về chú mèo máy thông minh Doraemon và nhóm bạn Nobita, Shizuka, Suneo, Jaian, Dekisugi sẽ đưa chúng ta bước vào thế giới hồn nhiên, trong sáng đầy ắp tiếng cười với một kho bảo bối kì diệu - những bảo bối biến ước mơ của chúng ta thành sự thật. Nhưng trên tất cả Doraemon là hiện thân của tình bạn cao đẹp, của niềm khát khao vươn tới những tầm cao.', N'Doraemon2-1.jpg', N'Doraemon2-2.jpg', N'Doraemon2-3.jpg', N'Doraemon2-4.jpg', N'Doraemon2-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935270704704', N'Đắc Nhân Tâm', 8, 21, 2024, 2, 1000, 0, 100000.0000, 0.2, 1, N'Đắc Nhân Tâm

Một trong những cuốn sách thay đổi cuộc đời hàng triệu người trên thế giới

Đây là phiên bản được dịch từ phiên bản “How to Win Friends and Influence People” do nhà xuất bản Simon and Schuster xuất bản lần đầu tiên năm 1936.

“Đắc nhân tâm” là cuốn sách được lan tỏa rộng rãi và có sức ảnh hưởng vô cùng lớn, giúp thay đổi cuộc đời hàng triệu người trên thế giới. Đây là một trong những cuốn sách làm thay đổi cuộc đời của hàng triệu người trên toàn thế giới.

“Đắc nhân tâm” đem lại những giá trị tuyệt vời cho người đọc, bao gồm những lời khuyên bổ ích về cách ứng xử trong cuộc sống hằng ngày. Sức lan tỏa của cuốn sách vô cùng lớn, tác động tới nhiều tầng lớp và nhiều đối tượng khác nhau.', N'8935270704704_1_DNT1.jpg', N'8935270704704_2_DNT2.jpg', N'8935270704704_3_DNT3.jpg', N'8935270704704_4_DNT4.jpg', N'8935270704704_5_DNT5.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935352606865', N'Wanted - Tuyển Tập Truyện Ngắn Eiichiro Oda (Tái Bản 2024)
', 1, 17, 2024, 1, 55, 0, 30000.0000, 0.02, 0, N'Gill Bastar, kẻ bị truy nã đắt giá nhất trong lịch sử, lại bị một hồn ma lẽo đẽo bám theo!?

Có thể xem "WANTED" là tác phẩm đầu tay kinh điển với sự xuất hiện của một Luffy rất khác những gì bạn biết!! Đây cũng chính là nguồn cảm hứng để tác phẩm huyền thoại "ONE PIECE" ra đời! "ROMANCE DAWN" cùng 3 mẩu truyện chưa kể tên đang chờ bạn khám phá!!', N'Wanted1-1.jpg', N'Wanted1-2.jpg', N'Wanted1-3.jpg', N'Wanted1-4.jpg', N'Wanted1-5.jpg', 4, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8935352614860', N'Tủ Sách Danh Nhân - Fujiko F Fujio - Người Vẽ Nên Những Giấc Mơ Cho Trẻ Em - Tác Giả Bộ Truyện "Doraemon" Fujiko F Fujio - Bìa Cứng', 1, 15, 2020, 1, 66, 1, 112000.0000, 0.04, 0, N'"Tủ sách danh nhân FUJIKO F FUJIO - Người vẽ nên những giấc mơ cho trẻ em" là tập sách tiểu sử về họa sĩ Fujiko F Fujio tái bản với hình thức mới 2024 nhân dịp kỉ niệm 90 năm ngày sinh của tác giả. Đây là cuốn tiểu sử bằng tranh về cuộc đời và sự nghiệp của cố tác giả từ khi ông còn là cậu bé Fujimoto say mê vẽ vời, đến những tháng ngày cuối đời vẫn tận tụy cống hiến cho nền truyện tranh Nhật Bản. Ngòi bút của ông đã vẽ nên những "ngôi sao" sáng trong thế giới của chính họa sĩ, đồng thời tạo nên tuổi thơ của biết bao trẻ em trên toàn thế giới.', N'Doraemon1-1.jpg', N'Doraemon1-2.jpg', N'Doraemon1-3.jpg', N'Doraemon1-4.jpg', N'Doraemon1-1.jpg', 0, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936049953569', N'Tinh Hoa Văn Học Việt Nam - Truyện Ngắn Nguyễn Công Hoan
', 8, 10, 2016, 5, 56, 1, 80000.0000, 0.23, 1, N'Tinh Hoa Văn Học Việt Nam - Truyện Ngắn Nguyễn Công Hoan

Nguyễn Công Hoan (1903 - 1977) là nhà văn tiêu biểu của văn học hiện thực phê phán Việt Nam. Trong cuộc đời sáng tác của mình, ông để lại một di sản nghệ thuật với hơn 200 truyện ngắn, gần 30 truyện dài và nhiều tiểu luận văn học.

Hoạt động văn học của Nguyễn Công Hoan luôn song hành cùng với sự nghiệp cách mạng chống Mỹ cứu nước. Chính vì thế trong các sáng tác của ông, bức tranh xã hội của người nông dân dưới mới tầng áp bức hiện ra chân thực nhất, rõ nét nhất

Từ điển bách khoa Việt Nam cũng đánh giá: ''Có thể nói Nguyễn Công Hoan là ngọn cờ đầu của văn học hiện thực phê phán Việt Nam... Nguyễn Công Hoan đến với chủ nghĩa hiện thực bằng văn học trào phúng. Từ những truyện đầu tiên, ông đã tìm đề tài trong những người nghèo khổ, cùng khốn của xã hội. Đa số nhân vật phản diện của ông đều thuộc tầng lớp thượng lưu giàu có và quan lại, cường hào. Toàn những cảnh xấu xa, bỉ ổi, những chuyện bất công, ngang ngược, những con người ghê tởm, đáng khinh bỉ. Nguyễn Công Hoan tạo ra những tình huống bất ngờ, rồi phá lên cười và làm cho người khác cười theo, nhưng ngẫm lại thật thương tâm đau xót.''', N'THVHVN1-1.jpg', N'THVHVN1-2.jpg', N'THVHVN1-3.jpg', N'THVHVN1-4.jpg', N'THVHVN1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067604764', N'Gió Lạnh Đầu Mùa - Tập Truyện Ngắn (Tái Bản 2022)', 8, 7, 2022, 2, 69, 0, 80000.0000, 0.3, 1, N'Gió Lạnh Đầu Mùa - Tập Truyện Ngắn (Tái Bản 2022)

Gió lạnh đầu mùa tập hợp toàn bộ những tác phẩm trong tập truyện ngắn Gió đầu mùa của nhà văn Thạch Lam, cuốn sách bao gồm các truyện: Đứa con đầu lòng, Nhà mẹ Lê, Trở về…Trong những truyện ngắn của ông người ta thấm thía nỗi khổ đau, bất hạnh, hoàn cảnh éo le của những con người nghèo khổ vừa cảm nhận sâu sắc tình người ấm nồng, cao quý, thiêng liêng.

Khi giới thiệu về tập truyện ngắn Gió đầu mùa, Thạch Lam viết rằng: "Đối với tôi văn chương không phải là một cách đem đến cho người đọc sự thoát ly trong sự quên, trái lại văn chương là một thứ khí giới thanh cao và đắc lực mà chúng ta có, để vừa tố cáo và thay đổi một cái thế giới giả dối và tàn ác, làm cho lòng người được thêm trong sạch và phong phú hơn".

Quả thực Thạch Lam đã rất trung thành với triết lý viết văn này và từng trang truyện của ông đều hướng về lớp người lao động bần cùng trong những khung cảnh ảm đạm, heo hút. Một mẹ Lê góa bụa, nghèo khổ phải nuôi một đàn con đông đúc, một bác Dư làm phu xe ở phố hàng Bột, cô Tâm hàng xén trong buổi hoàng hôn... Thạch Lam không gắn nhân vật với những sự kiện bi thảm hóa hoàn cảnh của họ nhưng cũng không khoác lên họ "một thứ ánh trăng lừa dối". Chính vì vậy, tác phẩm của Thạch Lam giữ được chất hiện thực nhưng không quá bi kịch như Lão Hạc, Chí Phèo... của Nam Cao.', N'TL6-1.jpg', N'TL6-2.jpg', N'TL6-3.jpg', N'TL6-4.jpg', N'TL6-4.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067604825', N'Chí Phèo', 8, 4, 1998, 5, 77, 0, 50000.0000, 0.3, 1, N'“Chí Phèo” – tập truyện ngắn tái hiện bức tranh chân thực nông thôn Việt Nam trước 1945, nghèo đói, xơ xác trên con đường phá sản, bần cùng, hết sức thê thảm, người nông dân bị đẩy vào con đường tha hóa, lưu manh hóa. Nam Cao không hề bôi nhọ người nông dân, trái lại nhà văn đi sâu vào nội tâm nhân vật để khẳng định nhân phẩm và bản chất lương thiện ngay cả khi bị vùi dập, cướp mất cà nhân hình, nhân tính của người nông dân, đồng thời kết án đanh thép cái xã hội tàn bạo đó trước 1945.

Những sáng tác của Nam Cao ngoài giá trị hiện thực sâu sắc, các tác phẩm đi sâu vào nội tâm nhân vật, để lại những cảm xúc sâu lắng trong lòng người đọc.', N'TP1-1.jpg', N'TP1-2.jpg', N'TP1-3.jpg', N'TP1-4.jpg', N'TP1-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067604832', N'Vợ Nhặt (Tái Bản 2022)', 8, 5, 2022, 5, 88, 1, 60000.0000, 0.3, 1, N'Vợ Nhặt (Tái Bản 2022)

Kim Lân tên thật là Nguyễn Văn Tài, sinh ngày 1 tháng 8 năm 1920.

Ông quê ở làng Phù Lưu, xã Tân Hồng, huyện Từ Sơn (nay là làng Phù Lưu, phường Đông Ngàn, thị xã Từ Sơn), tỉnh Bắc Ninh. Do hoàn cảnh gia đình khó khăn, ông chỉ được học hết bậc tiểu học rồi phải đi làm. Kim Lân bắt đầu viết truyện ngắn từ năm 1941. Một số truyện (Vợ nhặt, Đứa con người vợ lẽ,...) mang tính chất tự truyện nhưng đã thể hiện được không khí tiêu điều, ảm đạm của nông thôn Việt Nam và cuộc sống lam lũ, vất vả của người nông dân thời kì đó.

Sau Cách Mạng tháng Tám, Kim Lân tiếp tục làm báo, viết văn. Ông vẫn chuyên về truyện ngắn và vẫn viết về làng quê Việt Nam - mảng hiện thực mà từ lâu ông đã hiểu biết sâu sắc. Những tác phẩm chính: Nên vợ nên chồng (tập truyện ngắn, 1955), Con chó xấu xí (tập truyện ngắn, 1962).

Tập truyện ngắn “Vợ nhặt” tập hợp những truyện ngắn đặc sắc nhất của Kim Lân – một cây bút truyện ngắn vững vàng, viết về cuộc sống và con người ở nông thôn bằng tình cảm, tâm hồn của một người vốn là con đẻ của đồng ruộng.', N'VN2022-1.jpg', N'VN2022-2.jpg', N'VN2022-3.jpg', N'VN2022-4.jpg', N'VN2022-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067604955', N'Lều Chõng (Tái Bản 2022)
', 8, 3, 2022, 5, 100, 1, 90000.0000, 0.25, 1, N'Ngô Tất Tố được truy tặng Giải thưởng Hồ Chí Minh về văn học nghệ thuật Đợt I (1996). Từ gần 20 năm nay, Thủ đô Hà Nội thường xuyên tổ chức Giải thưởng báo chí Ngô Tất Tố hàng năm. Trên cả nước có 8 thành phố lớn có phố và đường phố mang tên Ngô Tất Tố.

"Lều chõng" đã thực hiện "một tua du lịch" sinh động, thú vị, giúp các thế hệ hậu sinh, lội ngược dòng thời gian để tiếp cận và khám phá về “Lều chõng”, khu vực có ý nghĩa đặc biệt, không chỉ là chuyện văn chương, chữ nghĩa mà còn gắn bó mật thiết đến vận mệnh đại sự của quốc gia, đến sự tồn vong, hưng thịnh của đất nước', N'LC1-1.jpg', N'LC1-2.jpg', N'LC1-3.jpg', N'LC1-4.jpg', N'LC1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067607956', N'Tuyển Tập Thạch Lam (2023)', 8, 7, 2023, 2, 48, 1, 145000.0000, 0.23, 1, N'Trong NXB Văn Học Việt Nam trước cách mạng 1945, Thạch Lam là một trong số những nhà văn được nhiều cảm tình của người đọc. Những tác phẩm như:"Hai đứa trẻ", "Gió lạnh đầu mùa", "Nhà mẹ Lê", "Dưới bóng hoàng lan" hay "Hà Nội băm sáu phố phường"... đã để lại nhiều dấu ấn khó quên trong biết bao độc giả bởi "nó là cái kết tinh của một tâm hồn nhạy cảm và từng trải về sự đời"
"Tuyển tập Thạch Lam” xin trân trọng giới thiệu đến quý độc giả những tác phẩm xuất sắc nhất của nhà văn Thạch Lam: Hà Nội băm sáu phố phường, Qùa Hà Nội, Trẻ con lấy vợ; Theo giòng; Hà Nội ban đêm; Những biển hàng; Người ta viết chữ Tây; Hai đứa trẻ; Dưới bóng hoàng lan; Nhà mẹ Lê; Gió lạnh đầu mùa; Sợi tóc; Hai lần chết...', N'TL2-1.jpg', N'TL2-2.jpg', N'TL2-3.jpg', N'TL2-4.jpg', N'TL2-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067607970', N'Tuyển Tập Ngô Tất Tố (2023)', 8, 3, 2023, 5, 45, 1, 165000.0000, 0.23, 1, N'Ngô Tất Tố sinh tại làng Lộc Hà, tổng Hội Phụ, phủ Từ Sơn, nay là thôn Lộc Hà, huyện Đông Anh, Hà Nội

Ông là một trong những nhà văn sáng lập trào lưu hiện thực trong nền NXB Văn Học nước nhà trước năm 1945 với các tác phẩm tiêu biểu như Tắt đèn, Việc làng, Lều chõng, Tập án cái đình...

Ngô Tất Tố đồng thời là nhà báo nổi tiếng với biệt tài viết tản văn và chính luận, là nhà văn hoá thành danh với các pho truyện lịch sử, khảo cứu triết học, dịch thuật, phê bình...

Với tổng số hơn 30 bút danh,    trên hơn 30 tờ báo, tạp chí, suốt 30 năm cầm bút viết văn làm báo, Ngô Tất Tố đã để lại hơn 1500 tác phẩm các thể loại, trong đó có 1350 di tác..

Ông được truy tặng Giải thưởng Hồ Chí Minh về NXB Văn Học nghệ thuật Đợt I (1996).

Trên cả nước có 8 thành phố lớn có phố và đường phố mang tên Ngô Tất Tố.', N'TTNTT-1.jpg', N'TTNTT-2.jpg', N'TTNTT-3.jpg', N'TTNTT-4.jpg', N'TTNTT-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936067609158', N'Tuyển Tập Nguyễn Công Hoan (Tái Bản 2023)', 8, 10, 2023, 5, 54, 0, 165000.0000, 0.3, 1, N'Tuyển Tập Nguyễn Công Hoan

Nguyễn Công Hoan sinh ngày 6 tháng 3 năm 1903 tại làng Xuân Cầu, xã Nghĩa Trụ, tỉnh Hưng Yên, trong một gia đình Nho học. Thân sinh ông là Nguyễn Đạo Khang làm huấn đạo, một ngạch quan nhỏ trong giáo giới. Song vì gia đình đông anh em, nên từ khi bốn tuổi ông đã được ông bác nuôi và cho ăn học. Ông bác cũng là người học thức khí khái, đã đỗ phó bảng và làm tri phủ. Ở với bác, bao nhiêu chuyện trong phố phủ, chuyện quan, chuyện lính tráng, nha lại, chuyện những người nông dân đến cửa quan bị bóp nặn, tất cả đọng lại trong trí nhớ ông. Được người gia đình dạy truyền khẩu ngay từ bé những phương ngôn, tục ngữ, ca dao, ngụ ngôn, những văn thơ chống Pháp của những tác giả ẩn danh, và sau này khi bắt đầu đi học lớp dự bị, lớp sơ đẳng, ông đã thuộc từng đoạn sách như Việt Nam phong tục ký của Phạm Huy Hổ, Nam Hải dị nhân của Phan Kế Bính biên soạn. Kiều, Chinh phụ ngâm, thơ Hồ Xuân Hương, Tú Xương, Yên Đổ... Ông được nuôi lòng yêu NXB Văn Học, được bồi đắp chí khí yêu nước, phản kháng trước những áp bức bất công và con mắt nhìn của ông đã đầy tính trào lộng.

Khi bắt đầu cầm bút, ông không làm thơ mà đi thẳng vào văn xuôi. Theo ông nghĩ, văn xuôi cũng tức như lời ăn tiếng nói thường ngày. Ngay từ buổi đầu, ông tìm cách viết giản dị, sáng sủa, dễ hiểu. Do ham đọc văn thơ, ông đã có lối nhìn đời bằng tâm hồn thi sĩ. Tất cả đã tạo nên phong cách riêng của ông, cây bút hiện thực phê phán sắc sảo mang tính trữ tình.', N'NCH1-1.jpg', N'NCH1-2.jpg', N'NCH1-3.jpg', N'NCH1-4.jpg', N'NCH1-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936071678492', N'Người Kép Già - Truyện Ngắn Và Vừa Kim Lân (Với 18 Minh Họa Của Thành Chương)', 8, 5, 2019, 5, 56, 1, 360000.0000, 0.16, 1, N'Người kép già bao gồm những truyện ngắn và vừa của nhà văn Kim Lân mà tôi đã đọc những truyện này và có truyện đọc rất nhiều lần. Nhưng ấn bản lần này vẫn làm tôi ngập tràn cảm hứng và chìm sâu trong suy tưởng khi đọc lại. […] Những tác phẩm trong cuốn sách này của ông là những câuchuyện đời sống của gần một thế kỷ trước. Nhưng tất cả vẫn nhưvừa diễn ra. Ngôn ngữ và những thông điệp chứa đựng bên trongnhững câu chuyện của ông vẫn rực ấm như một dòng máu chảytrong cơ thể thời gian mà những người đương thời đang sốngtrong đó. Mọi hình thức xã hội luôn thay đổi nhưng bản chất củakiếp người không thay đổi, mọi ngôn ngữ có thể thay đổi nhưngbản chất của tình yêu thương con người và cái Thiện không hềthay đổi. Văn chương của nhà văn Kim Lân thuộc về những điềukhông thể thay đổi ấy. Ông đã chạm vào cái lõi của kiếp nhânsinh và ông cũng sống trong cái lõi của mọi kiếp nhân sinh vìvậy ông còn mãi đến bây giờ.

Ấn phẩm mới mang tên Người kép già có một điều vô cùng đặc biệt. Đó là những phụ bản của họa sỹ danh tiếng Thành Chương. Họa sỹ Thành Chương là con trai nhà văn Kim Lân. Nhưng không phải vì lý do đó mà họa sỹ đã vẽ những phụ bản hiện đại nhưng lại chứa đựng tinh thần của những câu chuyện cha mình đã viết kể cả những câu chuyện từ khi họa sỹ chưa ra đời. Giữa hai văn bản khác nhau của chữ và màu sắc, hình khối,
giữa hai thế hệ khác nhau nhiều điều nhưng ta vẫn thấy một cây cầu bắc qua hai bờ của sự khác biệt đó. Nhưng đó chỉ là sự khác biệt của thời gian và hình thức, còn những trụ cầu để bắc cây cầu ấy là Cái đẹp và Tư tưởng. Cũng như thời đại của những tác phẩm Kim Lân và con người Kim Lân có rất nhiều khác biệt với thời đại của những người đang đọc Kim Lân, nhưng sự yêu quívăn chương Kim Lân và sự kính trọng con người Kim Lân của bạn đọc thời nay và sau này lại được bắc bằng một cây cầu bởinhững trụ cầu như thế.', N'KimLan1-1.jpg', N'KimLan1-2.jpg', N'KimLan1-3.jpg', N'KimLan1-4.jpg', N'KimLan1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'8936203362206', N'Gió Đầu Mùa & Hà Nội Băm Sáu Phố Phường', 8, 7, 2024, 2, 47, 1, 230000.0000, 0.24, 1, N'Gió Đầu Mùa & Hà Nội Băm Sáu Phố Phường

Không mộng mơ lãng đãng như Nhất Linh, Khái Hưng, không dữ dội giằng xé như Nam Cao, Ngô Tất Tố, không chua chát giễu đời như Nguyễn Công Hoan, Vũ Trọng Phụng… Thạch Lam đã rẽ một lối rất riêng trong văn chương, qua mọi nẻo trần ai và để lại dấu ấn tuy nhỏ nhẹ, thanh lịch, nhưng không vì thế mà thiếu đi sự thâm trầm, sâu sắc.

Trong cuốn sách này, Đông A và Nhà xuất bản Văn học giới thiệu đến bạn đọc hai tác phẩm ở giai đoạn đầu và cuối sự nghiệp sáng tác ngắn ngủi mà tài hoa của Thạch Lam: Tập truyện ngắn Gió đầu mùa và tùy bút Hà-nội băm sáu phố phường. Phần văn bản của tập truyện ngắn Gió đầu mùa được thực hiện theo bản in lần đầu năm 1937 của nhà xuất bản Đời Nay, với Lời tựa do nhà văn Khái Hưng viết. Còn phần văn bản của tùy bút Hà-nội băm sáu phố phường được thực hiện theo bản in đầu tiên năm 1943 của nhà xuất bản Đời Nay, cũng do Khái Hưng viết Lời tựa. Hy vọng rằng, nỗ lực truy nguyên tác phẩm của người làm sách có thể đem lại chút cảm xúc kết nối giữa người đọc với những sáng tác từ gần một thế kỷ trước.

Các minh họa trong ấn phẩm được thực hiện bởi họa sĩ Đào Hải Phong – người đã xây dựng một phong cách riêng khó lẫn trong hội họa Việt Nam đương đại. Hà Nội hiện ra trong tranh Đào Hải Phong vừa quen thuộc vừa mới lạ, kiêu hãnh thâm trầm nhưng cũng đầy sinh khí. Minh họa của họa sĩ đồng điệu với văn chương Thạch Lam ở nét thanh lịch dịu dàng và tình yêu chân thành, tha thiết dành cho cảnh vật, con người, những giá trị đẹp đẽ và cao quý.

Mong rằng tập sách nhỏ này sẽ chạm đến cảm xúc của bạn, không những giúp bạn mường tượng rõ hơn về chân dung văn học của một trong những tác giả nổi bật nhất trên văn đàn Việt Nam thế kỷ XX, mà còn khơi tỏ thêm tình yêu quê hương, đất nước, con người, như cái cách mà những người nghệ sĩ đã yêu.', N'TL1-1.jpg', N'TL1-2.jpg', N'TL1-3.jpg', N'TL1-4.jpg', N'TL1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9780007220854', N'The Zahir', 6, 13, 2011, 4, 46, 0, 226000.0000, 0.13, 1, N'The Zahir

It begins with a glimpse or a passing thought. It ends in obsession.

One day a renowned author discovers that his wife, a war correspondent, has disappeared leaving no trace. Though time brings more success and new love, he remains mystified - and increasingly fascinated - by her absence. Was she kidnapped, blackmailed, or simply bored with their marriage? The unrest she causes is as strong as the attraction she exerts.

His search for her - and for the truth of his own life - takes him from France to Spain, Croatia and, eventually, the bleakly beautiful landscape of Central Asia. More than that, it takes him from the safety of his world to a totally unknown path, searching for a new understanding of the nature of love and the power of destiny.

With ''The Zahir'', Paulo Coelho demonstrates his powerful and captivating storytelling.', N'PC5-1.jpg', N'PC5-2.jpg', N'PC5-3.jpg', N'PC5-4.jpg', N'PC5-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9780007306084', N'The Winner Stands Alone', 6, 13, 2010, 4, 100, 0, 197000.0000, 0.13, 1, N'The Winner Stands Alone

The Winner Stands Alone is an enthralling novel by the incomparable Paulo Coelho.

The story is set during the Cannes International Film Festival and the entire action plays out over 24 hours. Igor is a wealthy Russian businessman. His wife Ewa left him two years ago and Igor has never really come to terms with their break up, especially as Ewa is now remarried to a famous fashion designer, Hamid Hussein. Igor is insanely jealous and when Ewa left him he told her that he would destroy ''whole worlds'' in order to get her back and he intends to keep his promise...

The star-studded film festival acts as a backdrop to a maniacal murder spree and we are introduced to various characters along the way, all of whom are desperately trying to get their big break in the shallow world of show business; Gabriela a young and naive actress who is being exploited by her agent and Jasmine a troubled young Rwandan refugee working as a model.

The Winner Stands Alone is a gripping, fast-paced thriller and Coelho cleverly weaves in elements of social satire, as he pokes fun at our celebrity and money obsessed culture.', N'PC1-1.jpg', N'PC1-2.jpg', N'PC1-3.jpg', N'PC1-4.jpg', N'PC1-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9780062355300', N'The Alchemist 25th Anniversary: A Fable About Following Your Dream', 6, 13, 2014, 4, 97, 0, 201000.0000, 0.1, 1, N'A special 25th anniversary edition of the extraordinary international bestseller, including a new Foreword by Paulo Coelho.

Combining magic, mysticism, wisdom and wonder into an inspiring tale of self-discovery, The Alchemist has become a modern classic, selling millions of copies around the world and transforming the lives of countless readers across generations.

Paulo Coelho''s masterpiece tells the mystical story of Santiago, an Andalusian shepherd boy who yearns to travel in search of a worldly treasure. His quest will lead him to riches far different—and far more satisfying—than he ever imagined. Santiago''s journey teaches us about the essential wisdom of listening to our hearts, of recognizing opportunity and learning to read the omens strewn along life''s path, and, most importantly, to follow our dreams.', N'PC4-1.jpg', N'PC4-2.jpg', N'PC4-3.jpg', N'PC4-4.jpg', N'PC4-5.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9780593736814', N'Mới mới mới', 5, 21, 2002, 2, 2, 0, 200000.0000, 0.2, 1, N'hdfhwgd', N'9780593736814_1_123123_1_bg.svg', N'9780593736814_2_123123_2_book1.svg', N'9780593736814_3_123123_3_logo.png', N'9780593736814_4_123123_4_NPN.png', N'9780593736814_5_123123_5_wave.png', NULL, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9780722532935', N'The Alchemist (Size:13x20cm)', 6, 13, 2022, 4, 56, 1, 256000.0000, 0.1, 1, N'A global phenomenon, The Alchemist has been read and loved by over 62 million readers, topping bestseller lists in 74 countries worldwide. Now this magical fable is beautifully repackaged in an edition that lovers of Paulo Coelho will want to treasure forever. Every few decades a book is published that changes the lives of its readers forever. This is such a book - a beautiful parable about learning to listen to your heart, read the omens strewn along life''s path and, above all, follow your dreams. Santiago, a young shepherd living in the hills of Andalucia, feels that there is more to life than his humble home and his flock. One day he finds the courage to follow his dreams into distant lands, each step galvanised by the knowledge that he is following the right path: his own. The people he meets along the way, the things he sees and the wisdom he learns are life-changing. With Paulo Coelho''s visionary blend of spirituality, magical realism and folklore, The Alchemist is a story with the power to inspire nations and change people''s lives.', N'PC9-1.jpg', N'PC9-2.jpg', N'PC9-3.jpg', N'PC9-4.jpg', N'PC9-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9780722534878', N'The Pilgrimage', 6, 13, 2020, 4, 75, 1, 205000.0000, 0.1, 1, N'No description', N'PC10-1.jpg', N'PC10-2.jpg', N'PC10-3.jpg', N'PC10-4.jpg', N'PC10-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043077940', N'Hai Đứa Trẻ (Tái Bản 2024)', 8, 7, 2024, 2, 59, 1, 120000.0000, 0.3, 1, N'Hai Đứa Trẻ

Cuốn sách tập hợp những truyện ngắn đặc sắc của nhà văn Thạch Lam: Nắng trong vườn, Gió lạnh đầu mùa, Tiếng chim kêu, Đứa con đầu lòng, Bắt đầu, Nhà mẹ Lê, Một cơn giận, Hai đứa trẻ, Đứa con, Trong bóng tối buổi chiều, Cuốn sách bỏ quên, Dưới bóng hoàng lan,...

"Đối với tôi văn chương không phải là một cách đem đến cho người đọc sự thoát li trong sự quên, trái lại văn chương là một thứ khí giới thanh cao và đắc lực mà chúng ta có, để vừa tố cáo và thay đổi một cái thể giới giả dối và tàn ác, làm cho lòng người được thêm trong sạch và phong phú hơn."', N'TL8.jpg', N'TL8.jpg', N'TL8.jpg', N'TL8.jpg', N'TL8.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043721843', N'Người Ngựa Ngựa Người (Tái Bản 2022)', 8, 10, 2022, 5, 35, 1, 76000.0000, 0.23, 1, N'Nguyễn Công Hoan (1903 - 1977) là nhà văn nổi tiếng của Việt Nam. Thế giới truyện ngắn Nguyễn Công Hoan đa dạng, phong phú như một "Bách khoa thư", một "tấn trò đời" mà đặc trưng là xã hội phong kiến của thực dân ở Việt Nam nửa đầu thế kỳ 20. Truyện ngắn Nguyễn Công Hoan có nhiều nét gần với truyện cười dân gian, tiếp thu truyền thống lạc quan của nhân dân muốn dùng tiếng cười như một " vũ khí của người mạnh" để tống tiễn cái lạc hậu, cái xẫu xa vào dĩ vãng...

Người ngựa ngựa người là tập truyện ngắn chọn lọc của nhà văn Nguyễn Công Hoan. Từ những truyện đầu tiên, ông đã tìm đề tài trong những người nghèo khổ, cùng khốn của xã hội. Đa số nhân vật phản diện của ông đều thuộc tầng lớp thượng lưu, giàu có và quan lại, cường hào. Toàn những cảnh xấu xa, bỉ ổi, những chuyện bất công, ngang ngược, những con người ghê tởm, đáng khinh bỉ. Nguyễn Công Hoan tạo ra những tình huống bất ngờ, rồi phá lên cười và làm cho người khác cười theo, nhưng ngẫm lại thật thương tâm đau xót!', N'NNNN.jpg', N'NNNN.jpg', N'NNNN.jpg', N'NNNN.jpg', N'NNNN.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043721898', N'Bước Đường Cùng (Tái Bản 2022)', 8, 10, 2022, 2, 76, 0, 59000.0000, 0.23, 1, N'Viết "Bước đường cùng", tác giả đã lường trước hậu quả là sách sẽ bị cấm. Thậm chí, người viết còn bị truy tố. Nhưng ông không sợ. Ông nghĩ, nếu bị nặng lắm thì ông cũng chỉ lãnh án từ một tới năm năm tù. Khi trở về, ông sẽ lại viết văn.

Bước đường cùng là tiểu thuyết nói về anh Pha, một nông dân nghèo bị Trương Thi – người hàng xóm không tốt bỏ bã rượu vào ruộng rồi báo Tây đoan về bắt. Nhưng Thi bỏ lầm vào ruộng Nghị Lại, một địa chủ lớn trong vùng. Pha thoát nạn. Nghị Lại xúi Trương Thi kiện Pha, rồi lại xúi Pha kiện Trương Thi… cứ như vậy, Nghị Lang thành ngư ông đắc lợi. Vụ thuế đến, lính cơ về làng, tróc nã, bắt trói, cùm kẹp; Sau vụ thuế, nhiều gia đình nông dân khánh kiệt, trong khi Nghị Lại và bọn kỳ hào kiếm hàng trăm. Vợ chồng Pha phải đến làm thuê cho Nghị Lại, vất vả quần quật mà cơm độn cà thiu không đủ no. Chị Pha về ốm nặng, Pha lại phải đến vay thóc Nghị Lại để ăn. Vợ anh vẫn ốm, không có tiền mua thuốc, chỉ uống mấy thứ lá linh tinh, rồi lễ bái, chạy mồ... Anh phải đến phục dịch nhà Nghị Lại, rồi bị đòn, bị đuổi oan ức. Nước sông lên to, Pha và hàng trăm nông dân phải đi hộ đê, trong khi vợ con nhịn đói. Rồi nạn dịch tả. Chị Pha chỉ vì không chịu tiêm chủng đã chết về dịch. Đã thế, Pha còn bị “làng” bắt vạ vì cho rằng anh “hỗn xược với thần” để làng bị dịch! Đứa con của anh cũng chết nốt, chỉ còn mình anh trơ trọi, túng đói...', N'BDC-1.jpg', N'BDC-2.jpg', N'BDC-3.jpg', N'BDC-4.jpg', N'BDC-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043723892', N'Lá Ngọc Cành Vàng (Tái Bản 2022)', 8, 10, 2024, 5, 47, 1, 54000.0000, 0.23, 1, N'Lá Ngọc Cành Vàng là đoản thiên tiểu thuyết được nhà văn tiền chiến Nguyễn Công Hoan (1903-1977) viết xong năm 1935 và xuất bản lần đầu tiên vào tháng 5 năm 1939. Trí Việt Books phát hành năm 2018.

Lá ngọc cành vàng kể về Nga một nàng tiểu thư con quan tri phủ đem lòng yêu thương tình si gởi đến cho Chi, con trai của một mụ bán hàng quán góa chồng nghèo xơ xác. Gia đình quan tri phủ biết được thì tìm mọi cách ngăn cản cấm đoán mối tình ngang trái ấy. Ông quan tri phủ cho rằng cái mối tình không môn đăng hộ đối ấy là một tội bất hiếu với liệt tổ liệt tông và ông đã lạm dụng quyền làm cha mà hành hạ tinh thần của cả Nga và Chi rất khắc nghiệt. Hành hạ không xong ông ta thẳng tay trừng trị thể xác và ra tối hậu thư bắt đứa con gái phải tuyệt giao với người tình. 

Không chịu nổi sự hành hạ về tinh thần lẫn thể xác, cô con dái đã lên nhà người chú tạm nương náu. Nơi đây cô nhung nhớ người yêu quá đỗi nên hóa thành điên dại. Khi Chi đến thăm nom chăm sóc an ủi thì Nga mới được bình phục trở lại rồi lửa gần rơm lâu ngày cũng bén và Nga có mang đứa con với Chi. Ông quan tri phủ biết được cái tin động trời này đã ra tay hành hạ Chi và mẹ của chàng rất man rợ, riêng đứa con gái thì ông ta bắt uống thuốc phá thai. Nga cự tuyệt  khiến quan tri phủ nổi cơn xung thiên đã xuống tay đánh đập đứa con gái cho đến chết.', N'LNCV-1.jpg', N'LNCV-2.jpg', N'LNCV-3.jpg', N'LNCV-4.jpg', N'LNCV-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043726855', N'Tập Án Cái Đình (Tái Bản)', 8, 3, 2018, 5, 95, 1, 51000.0000, 0.23, 1, N'Tập Án Cái Đình là một thiên phóng sự đăng lần đầu tiên trên báo "Con Ong" từ số 18/10/1939. Tập án cái đình viết về những hủ tục ở chốn đình trung, đặc biệt là những lễ nghi phiền phức, hủ bại. Ở đây thiên Phóng sự nghiêng về mặt miêu tả những phong tục, nói cho đúng hơn là những hủ tục kỳ quái được duy trì ở nông thôn. Nó cung cấp được nhiều tài liệu về mặt xã hội học. 

Trí Việt Books mới cho phát hành thiên phóng sự Tập án cái đình, để giúp bạn đọc cảm nhận rõ hơn về những tập tục một thời.', N'TACD.jpg', N'TACD.jpg', N'TACD.jpg', N'TACD.jpg', N'TACD.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043905342', N'Brida - Ma Thuật Yêu', 6, 13, 2023, 4, 75, 1, 135000.0000, 0.18, 1, N'Brida - Ma Thuật Yêu

Đã bao giờ bạn tự hỏi sứ mạng của mình trong cuộc đời này là gì? Đâu là con đường chúng ta phải đi trong suốt cuộc đời này? Liệu đó có phải là con đường đúng sẽ đem lại hạnh phúc cho bản thân? Và chúng ta sẽ lựa chọn và dũng cảm cất bước một cách kiên định, không quan tâm tới khó khăn hay hệ quả sẽ đối mặt?

Đã bao giờ bạn tự hỏi một nửa của mình có tồn tại ngoài kia? Liệu bạn sẽ gặp được một nửa của mình trong đời này? Liệu khi một nửa lướt qua đời mình và chúng ta lại để vụt mất? Liệu chúng ta có đủ niềm tin để biết, nếu kiếm tìm ắt hẳn sẽ gặp?

Từ thời khởi thủy đây là các câu hỏi muôn đời. Ngoài kia có quá nhiều người không đủ dũng cảm để cất bước, nhiều người từ bỏ và rồi sẽ sống theo dòng đời đưa đẩy và không thể nhận ra sự hào phóng mà Thượng đế đã bày ra trước mắt. Brida: ma thuật yêu – một tác phẩm tràn ngập lời văn đẹp như thơ của tác giả Paulo Coelho – chính là chìa khóa để giải đáp những khắc khoải muôn đời đó của con người.

Tác phẩm dẫn dắt người theo hành trình tìm kiếm minh triết của cô gái trẻ người Ireland, Brida. Mở đầu, Brida tìm đến hai Bậc Thầy. Đầu tiên là Magus, người dạy cô về Nhật Đạo (truyền dạy bí quyết xuyên không gian và thế giới xung quanh ta), và giúp cô chinh phục nỗi sợ hãi của mình. Nhưng Brida không hề biết rằng cô chính là “Người Duyên” của Magus. Người thầy thứ hai là Wicca. Chị đã dạy Brida kiến ​​​​thức và nghi lễ của Nguyệt Đạo (truyền dạy bí quyết xuyên thời gian và những thứ bị cầm giữ trong ký ức của thời gian). Trong khi thực hành những nghi lễ này, Brida bắt đầu hiểu rằng mình là một phù thủy. Tiết tấu của truyện ngày càng nhanh hơn, cuốn người đọc theo, khi mà Brida nhìn thấy tiền kiếp của mình – một phụ nữ mang Ân sủng có thể trò chuyện với các linh hồn.', N'PC6-1.jpg', N'PC6-2.jpg', N'PC6-3.jpg', N'PC6-4.jpg', N'PC6-5.jpg', 5, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043940336', N'Danh Tác Việt Nam - Truyện Ngắn Nam Cao', 8, 4, 2000, 5, 34, 1, 86000.0000, 0.23, 1, N'Đối với Nam Cao, cái quan trong hơn cả trong nhiệm vụ phản ánh chân thật cuộc sống là cái chân thật của tư tưởng, của nội tâm nhân vật. Xét tới cùng, cái quan trọng nhất trong tác phẩm không phải là bản thân sự kiện, biến cố tự thân mà là con người trước sự kiện, biến cố. Vì vậy, trong sáng tác của Nam Cao, hứng thú của những chi tiết tâm lý thường thay thế cho hứng thú của chính bản thân các sự kiện, biến cố.', N'TNNC.jpg', N'TNNC.jpg', N'TNNC.jpg', N'TNNC.jpg', N'TNNC.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043940343', N'Danh Tác Việt Nam - Truyện Ngắn Thạch Lam', 8, 7, 2022, 2, 75, 0, 65000.0000, 0.24, 1, N'Danh Tác Việt Nam - Truyện Ngắn Thạch Lam

Ngòi bút Thạch Lam tinh tế và trân trọng biết bao trước số phận người phụ nữ và trẻ em, nếu không thuộc lớp dưới đáy thì cũng là người ở cảnh bần hàn, hoặc đang rơi vào cảnh bần hàn, như trong Cô hàng xén, Hai đứa trẻ, Tối ba mươi.', N'TL4.jpg', N'TL4.jpg', N'TL4.jpg', N'TL4.jpg', N'TL4.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043946338', N'Danh Tác Việc Nam - Việc Làng', 8, 3, 2022, 5, 90, 1, 40000.0000, 0.23, 1, N'Trong tập phóng sự Việc làng, làng Việt Nam cổ xưa đã biến thành một triều đình phong kiến thu nhỏ, lợi dụng sự mê tín của dân chúng, thực dân phong kiến đã giở mọi trò lừa bịp nhằm thực hiện chính sách ngu dân, bóc lột.

"Thế mà hết đời này sang đời khác người ta vẫn nhẫn tâm bắt dân đeo cái xích sắt ấy mà lại muốn cho dân cường nước thịnh thì cũng lạ thay!" (trích Cứ để cho nó chết). "Hủ tục không phải là thứ thiên kinh địa nghĩa, nó vẫn có thể thay đổi. Vậy mà nó vẫn được coi như vị thần thiêng, không ai dám động đến nó... Lạ thay!" (trích Lớp người bị bỏ sót).

Phóng sự việc làng chứa đựng một khối lượng kiến thức sâu rộng, được ghi lại rất cụ thể, rành mạch, đã lôi cuốn bạn đọc đi từ ngạc nhiên này đến bất ngờ khác rất chi tiết về bộ mặt nông thôn với hàng loạt phong tục, hủ tục diễn ra liên miên dai dẳng trong đời sống và xã hội dân quê cách đây non một thế kỷ.', N'VL1-1.jpg', N'VL1-2.jpg', N'VL1-3.jpg', N'VL1-4.jpg', N'VL1-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786043947465', N'Ngày Mới', 8, 7, 2020, 2, 58, 1, 135000.0000, 0.23, 1, N'Ngày Mới

Nhà văn Thạch Lam (1910-1942) là một cây bút chính trong nhóm Tự Lực văn đoàn với quan niệm "Văn chương không phải là một cách đem đến cho người đọc sự thoát ly hay sự quên, trái lại văn chương là một thứ khí giới thanh cao và đắc lực mà chúng ta có, để vừa tố cáo và thay đổi một cái thế giới giả dối và tàn ác, làm cho lòng người được thêm trong sạch và phong phú hơn". Qua những sáng tác văn chương của Thạch Lam, ta cảm nhận được một tâm hồn nhạy cảm, lãng mạn và nhân ái của nhà văn. Đọc những áng văn giản dị và nhẹ nhàng; hiện thực đan xen lãng mạn của Thạch lam, người ta luôn thấy len lỏi những tia nắng của hy vọng, tình yêu thương và sự sống. Thế nên Nguyễn Tuân cũng nói: “Ngày nay đọc lại Thạch lam, vẫn thấy đầy đủ cái dư vị và cái nhã thú của những tác phẩm có cốt cách và phẩm chất văn học.”

Ngày Mới là một trong những tiểu thuyết nổi bật của Thạch Lam, được viết vào năm 1939. Truyện kể về nhân vật chính là Trường, một chàng trai nghèo vừa thi đỗ bằng thành chung. Trường từ chối sự sắp đặt hôn nhân của mẹ để kết hôn với Trinh - người con gái anh yêu, tuy nhiên Trường không ngờ cuộc sống sau hôn nhân đã đẩy anh vào nhiều áp lực. Ngày mới mang lại cái nhìn về cuộc sống của một gia đình, ở đó ta thấy những nỗi lo về cơm áo gạo tiền và tương lai nhưng họ vẫn luôn hy vọng vào một ngày mai tốt đẹp hơn.

“Một lần nữa, Trường thấy rõ rệt sự thi đỗ của chàng sẽ có một kết quả tốt cho cái đời sống chung của gia đình chàng. Đó là cái hy vọng độc nhất của những nhà nghèo như nhà chàng để bước lên được một địa vị cao hơn. Mẹ chàng đã để vào đấy bao nhiêu điều mong ước! Lúc chàng nộp giấy má để thi, mẹ chàng không ngần ngại mở cái tráp con, lấy ra năm tờ giấy bạc mới nguyên đưa cho; sự tin cậy ấy Trường thấy ân cần và thấm thía, bởi vì vốn nghèo nên chàng đã hiểu biết giá trị của đồng tiền.”', N'TL9-1.jpg', N'TL9-2.jpg', N'TL9-3.jpg', N'TL9-4.jpg', N'TL9-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786044771069', N'Tắt Đèn - Ngô Tất Tố (Tái Bản 2023)', 8, 3, 2023, 5, 49, 0, 42000.0000, 0.23, 1, N'Tắt đèn của nhà văn Ngô Tất Tố phản ánh rất chân thực cuộc sống khốn khổ của tầng lớp nông dân Việt Nam đầu thế kỷ XX dưới ách đô hộ của thực dân Pháp. Tác phẩm xoay quanh nhân vật chị Dậu và gia đình – một điển hình của cuộc sống bần cùng hóa sưu cao thuế nặng mà chế độ thực dân áp đặt lên xã hội Việt Nam. Trong cơn cùng cực chị Dậu phải bán khoai, bán bầy chó đẻ và bán cả đứa con để lấy tiền nộp sưu thuế cho chồng nhưng cuộc sống vẫn đi vào bế tắc, không lối thoát.

Trong tác phẩm, cảnh đời tràn nước mắt của gia đình chị Dậu đã được tái hiện một cách sống động trong từng câu chữ, chi tiết văn học với nhiều cung bậc cảm xúc của tác giả khiến người đọc không khỏi xúc động. Tác phẩm không chỉ kích thích niềm đam mê văn học ở thanh thiếu niên, mà còn bồi đắp cho lớp trẻ những tìm cảm tốt đẹp và khơi dậy lòng trắc ẩn ở các em.', N'TD1-1.jpg', N'TD1-2.jpg', N'TD1-3.jpg', N'TD1-1.jpg', N'TD1-1.jpg', 3, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786044771922', N'Vợ Nhặt (Tái Bản 2023)', 8, 5, 2023, 5, 15, 1, 47000.0000, 0.23, 1, N'Vợ Nhặt (Tái Bản 2023)

Kim Lân tên thật là Nguyễn Văn Tài (1921-2007), quê gốc: Thôn Phù Lưu, xã Tân Hồng, huyện Tiên Sơn, tỉnh Bắc Ninh. Đảng viên Đảng Cộng sản Việt Nam. Hội viên sáng lập Hội Nhà văn Việt Nam (1957). Nhà văn Kim Lân tham gia văn hóa Cứu quốc, trong kháng chiến chống Pháp công tác ở chiến khu Việt Bắc. Ông Từng là ủy viên Ban phụ trách Nhà xuất bản Văn học, trường bồi dưỡng những người viết trẻ, Tuần báo Văn nghệ, Nhà xuất bản Tác phẩm mới. Ông nhận Giải thưởng Nhà nước về Văn học Nghệ thuật năm 2000.

Tập truyện ngắn Vợ nhặt tập hợp những truyện ngắn đặc sắc nhất của Kim Lân - một cây bút truyện ngắn vững vàng, viết về cuộc sống và con người ở nông thôn bằng tình cảm, tâm hồn của một người vốn là con đẻ của đồng ruộng.', N'VN2023-1.jpg', N'VN2023-2.jpg', N'VN2023-3.jpg', N'VN2023-4.jpg', N'VN2023-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786044771946', N'Lão Hạc (Tái Bản 2023)', 8, 4, 2023, 5, 40, 1, 57000.0000, 0.23, 1, N'Lão Hạc là một truyện ngắn của nhà văn Nam Cao được viết năm 1943. Tác phẩm được đánh giá là một trong những truyện ngắn khá tiêu biểu của dòng văn học hiện thực, nội dung truyện đã phần nào phản ánh được hiện trạng xã hội Việt Nam trong giai đoạn trước Cách mạng tháng Tám.

Lão Hạc, một người nông dân chất phác, hiền lành. Lão góa vợ và có một người con trai nhưng vì quá nghèo nên không thể lấy vợ cho người con trai của mình. Người con trai lão vì thế đã rời bỏ quê hương để đến đồn điền cao su làm ăn kiếm tiền. Lão luôn trăn trở, suy nghĩ về tương lai của đứa con. Lão sống bằng nghề làm vườn, mảnh vườn mà vợ lão đã mất bao công sức để mua về và để lại cho con trai lão. So với những người khác lúc đó, gia cảnh của lão khá đầy đủ, tuy nhiên do ốm yếu hơn hai tháng và cũng vì trận bão mà lão không có việc gì để làm .', N'LH2-1.jpg', N'LH2-2.jpg', N'LH2-3.jpg', N'LH2-4.jpg', N'LH2-5.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786044916866', N'Thạch Lam Tuyển Tập', 8, 7, 2024, 2, 56, 1, 136000.0000, 0.3, 1, N'Thạch Lam Tuyển Tập

Một cuốn sách tập hợp những tác phẩm của nhà văn nổi tiến Thạch Lam. Với lối văn nhuần nhị, tinh tế, gọn và gợi được thật là rành rõ những trạng thái của sinh hoạt, xúc cảm và tâm hồn. Ngôn ngữ kể của Thạch Lam không hề to tát, cấu trúc không phức tạp, vội vàng đủ phô diễm những cảnh ngộ hoặc tâm trạng cần phô diễn. Thạch Lam tuyển tập tập hợp nhiều truyện ngắn và tiểu thuyết đầy giá trị, để lại nhiều ấn tượng sâu sắc trong tim bạn đọc.', N'TL1.jpg', N'TL1.jpg', N'TL1.jpg', N'TL1.jpg', N'TL1.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786044916873', N'Nam Cao Tuyển Tập', 8, 4, 2020, 5, 49, 1, 133000.0000, 0.18, 1, N'Cuốn sách Nam Cao tuyển tập gồm rất nhiều những truyện ngắn hay và đặc sắc nhất của Nam Cao. Các tác phẩm của ông đi sâu vào những phận người được khắc họa rõ nét giữa cái đói nghèo cùng khổ, nhưng tài hoa của ông là đã khéo léo sử dụng ngòi bút lạnh lùng, không chút khoan nhượng, trực tiếp đi thẳng và đi sâu vào miêu tả chân thực cuộc sống nghèo khổ, tủi nhục của người tiểu tư sản cũng như những người nông dân, khắc họa vào trong những đau đớn tâm hồn của họ và đặt ra những vấn đề có ý nghĩa xã hội sâu sắc.', N'NCTT1.jpg', N'NCTT1.jpg', N'NCTT1.jpg', N'NCTT1.jpg', N'NCTT1.jpg', 1, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786044917016', N'Dưới Bóng Hoàng Lan', 8, 7, 2024, 2, 85, 0, 100000.0000, 0.32, 1, N'Dưới Bóng Hoàng Lan

Khám Phá Vẻ Đẹp Nhẹ Nhàng Của "Dưới Bóng Hoàng Lan" Của Thạch Lam

"Dưới Bóng Hoàng Lan" – tác phẩm tinh tế của Thạch Lam, mang đến cho bạn một cái nhìn sâu lắng về cuộc sống và tâm tư con người qua lối viết nhẹ nhàng nhưng đầy cảm xúc. Đây là một tác phẩm không thể bỏ qua cho những ai yêu thích văn học hiện thực và những câu chuyện đầy nhân văn.

Nội dung hấp dẫn: "Dưới Bóng Hoàng Lan" là một tập hợp các truyện ngắn mô tả cuộc sống và những tâm tư của các nhân vật trong một xã hội đầy biến động. Thạch Lam đã khéo léo khắc họa những khoảnh khắc tinh tế, từ những mảnh đời đơn giản đến những cảm xúc sâu sắc. Tác phẩm mang đến một cái nhìn chân thực về những khó khăn và niềm vui trong cuộc sống, đồng thời phản ánh sự xao xuyến và tìm kiếm ý nghĩa trong những điều nhỏ nhặt.', N'TL7-1.jpg', N'TL7-2.jpg', N'TL7-3.jpg', N'TL7-4.jpg', N'TL7-5.jpg', 2, 0)
INSERT [dbo].[Book] ([isbn], [title], [category_id], [author_id], [year_of_publication], [publisher_id], [quantity], [cover], [price], [discount_percent], [is_discount], [description], [url1], [url2], [url3], [url4], [url5], [cluster], [is_discontinued]) VALUES (N'9786049853449', N'Danh Tác Việt Nam - Nguyễn Công Hoan Tuyển Tập
', 8, 10, 2019, 5, 56, 1, 109000.0000, 0.23, 1, N'Nguyễn Công Hoan - tuyển tập là tập hợp đa phần những truyện ngắn nổi tiếng của nhà văn Nguyễn Công Hoan và phần Tiểu thuyết Bước đường cùng của ông.

Nguyễn Công Hoan sinh ngày 6 tháng 3 năm 1903, tại thôn Xuân Cầu, xã Nghĩa Trụ, huyện Văn Giang, tỉnh Bắc Ninh, nay là tỉnh Hải Hưng, trong một gia đình Nho học. Chính nơi sinh cũng là quê hương ông.

Ông bắt đầu viết văn rất sớm, ngay từ khi còn đương học ở trường Bưởi. Tập truyện ngắn đầu tiên của ông là Kiếp hồng nhan xuất hiện năm 1923, khi ông tròn hai mươi tuổi. Từ đó ông viết nhiều truyện ngắn và truyện dài đăng trên các báo đương thời. Năm 1932 ông bắt đầu được bạn đọc chú ý khi cuốn truyện dài Những cảnh khốn nạn ra đời và nổi tiếng sau khi ra tập Kép Tư Bền (1935).

Truyện ngắn Nguyễn Công Hoan, rất ngắn, cấu trúc gọn và đầy tính hài hước. Ngôn ngữ của ông giản dị, chữ dùng chọn lọc chính xác gợi những hình ảnh đậm nét, dí dỏm và thông minh. Gấp trang sách, người đọc cảm thấy không thể chịu đựng nổi nếu những cảnh huống như vừa đọc còn tiếp tục diễn ra trong cuộc sống con người. Nghệ thuật trào phúng của ông không chỉ bộc lộ rõ ưu thế trong truyện ngắn.

Theo Nguyễn Công Hoan tự nhận xét, sở trường của ông là truyện ngắn chứ không phải tiểu thuyết. Ông nói ông thích viết truyện ngắn hơn tiểu thuyết: "Tôi chỉ viết truyện dài khi nào tôi lười tìm đề tài để viết truyện ngắn". Tuy nhiên, với không ít nhà nghiên cứu, phê bình văn học, tiểu thuyết Bước đường cùng vẫn là một trong những tác phẩm quan trọng nhất của đời văn Nguyễn Công Hoan. Cuốn sách từng được đưa vào giảng dạy trong nhà trường và được ghi nhận như một trong những tác phẩm tiêu biểu nhất của dòng văn học hiện thực phê phán giai đoạn 1930-1945.', N'NCH2-1.jpg', N'NCH2-2.jpg', N'NCH2-3.jpg', N'NCH2-4.jpg', N'NCH2-5.jpg', 1, 0)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (5, N'Kỹ Năng Sống')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (4, N'Tiểu Thuyết')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (1, N'Truyện Tranh')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (8, N'Văn Học')
INSERT [dbo].[Category] ([category_id], [category_name]) VALUES (6, N'Viễn Tưởng')
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[History] ON 

INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (1, N'nnthienphuc', CAST(N'2024-12-08T22:57:44.067' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974148715')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (2, N'nnthienphuc', CAST(N'2024-12-08T22:57:49.043' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974158721')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (3, N'nnthienphuc', CAST(N'2024-12-08T22:57:53.457' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974164135')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (4, N'nnthienphuc', CAST(N'2024-12-08T22:57:58.590' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8935270704704')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (5, N'nnthienphuc', CAST(N'2024-12-08T23:07:08.563' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974164135')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (6, N'nnthienphuc', CAST(N'2024-12-08T23:07:10.550' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974164135')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (7, N'nnthienphuc', CAST(N'2024-12-08T23:07:15.960' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974176428')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (8, N'nnthienphuc', CAST(N'2024-12-08T23:07:17.970' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974176428')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (9, N'nnthienphuc', CAST(N'2024-12-08T23:07:20.160' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974176428')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (10, N'nnthienphuc', CAST(N'2024-12-08T23:07:36.737' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974179978')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (11, N'nnthienphuc', CAST(N'2024-12-08T23:07:44.273' AS DateTime), N'F75C7C6B8C6484D169FE1C8765D40525', N'8934974179978')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (12, N'nnthienphuc', CAST(N'2024-12-08T23:08:41.377' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8934974148715')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (13, N'nnthienphuc', CAST(N'2024-12-08T23:08:45.080' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8934974158721')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (14, N'nnthienphuc', CAST(N'2024-12-08T23:08:55.640' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8935235240483')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (15, N'nnthienphuc', CAST(N'2024-12-08T23:08:57.627' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8935235240483')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (16, N'nnthienphuc', CAST(N'2024-12-08T23:08:59.920' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8935235240483')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (17, N'nnthienphuc', CAST(N'2024-12-08T23:09:05.403' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8935244876437')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (18, N'nnthienphuc', CAST(N'2024-12-08T23:09:07.347' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8935244876437')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (19, N'nnthienphuc', CAST(N'2024-12-08T23:14:20.340' AS DateTime), N'223EC3E979F9E4C19BDD18D215162584', N'8794069305344')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (20, N'phucnaoto', CAST(N'2024-12-09T00:40:44.763' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8935244865981')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (21, N'phucnaoto', CAST(N'2024-12-09T00:41:03.943' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8935244865981')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (22, N'phucnaoto', CAST(N'2024-12-09T00:41:15.280' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8935244866049')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (23, N'phucnaoto', CAST(N'2024-12-09T00:41:45.110' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8794069305344')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (24, N'phucnaoto', CAST(N'2024-12-09T00:41:52.387' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8935244865882')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (25, N'phucnaoto', CAST(N'2024-12-09T00:42:03.557' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8935244866049')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (26, N'phucnaoto', CAST(N'2024-12-09T01:00:19.320' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8794069305344')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (27, N'phucnaoto', CAST(N'2024-12-09T01:00:26.947' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8794069305344')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (28, N'phucnaoto', CAST(N'2024-12-09T01:00:33.490' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8794069305344')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (29, N'phucnaoto', CAST(N'2024-12-09T01:00:41.663' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8794069305344')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (30, N'phucnaoto', CAST(N'2024-12-09T01:01:32.800' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8934974158721')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (31, N'phucnaoto', CAST(N'2024-12-09T01:01:37.157' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8934974158721')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (32, N'phucnaoto', CAST(N'2024-12-09T01:01:44.877' AS DateTime), N'D2C6CDF13D99C0AB563AE54A6CE007B2', N'8934974158721')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (33, N'nnthienphuc', CAST(N'2024-12-09T01:33:50.587' AS DateTime), N'814B908527F0A647A0672E6D2DBDE188', N'8935244866032')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (34, N'nnthienphuc', CAST(N'2024-12-09T01:33:58.657' AS DateTime), N'814B908527F0A647A0672E6D2DBDE188', N'8935244866032')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (35, N'nnthienphuc', CAST(N'2024-12-09T01:34:11.347' AS DateTime), N'814B908527F0A647A0672E6D2DBDE188', N'8934974160328')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (36, N'nnthienphuc', CAST(N'2024-12-09T01:34:14.773' AS DateTime), N'814B908527F0A647A0672E6D2DBDE188', N'8934974160328')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (37, N'nnthienphuc', CAST(N'2024-12-09T01:44:17.323' AS DateTime), N'90969200412770B6C72D917737800907', N'8935244865882')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (38, N'nnthienphuc', CAST(N'2024-12-09T01:44:20.773' AS DateTime), N'90969200412770B6C72D917737800907', N'8935244865882')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (39, N'nnthienphuc', CAST(N'2024-12-09T01:44:32.660' AS DateTime), N'90969200412770B6C72D917737800907', N'8935244865882')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (40, N'nnthienphuc', CAST(N'2024-12-09T01:44:38.420' AS DateTime), N'90969200412770B6C72D917737800907', N'8935244866049')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (41, N'nnthienphuc', CAST(N'2024-12-09T01:44:47.677' AS DateTime), N'90969200412770B6C72D917737800907', N'8935244868449')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (42, N'nnthienphuc', CAST(N'2024-12-09T01:44:51.457' AS DateTime), N'90969200412770B6C72D917737800907', N'8935244868449')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (43, N'nnthienphuc', CAST(N'2024-12-09T01:44:57.987' AS DateTime), N'90969200412770B6C72D917737800907', N'8934974160328')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (44, N'nnthienphuc', CAST(N'2024-12-09T01:45:00.680' AS DateTime), N'90969200412770B6C72D917737800907', N'8934974160328')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (45, N'nnthienphuc', CAST(N'2024-12-09T02:29:33.780' AS DateTime), N'F7757241F8FF5A8F59CF0FF23FB71DF6', N'8934974151647')
INSERT [dbo].[History] ([history_id], [user_id], [request_time], [session_id], [isbn]) VALUES (46, N'nnthienphuc', CAST(N'2024-12-09T02:29:40.510' AS DateTime), N'F7757241F8FF5A8F59CF0FF23FB71DF6', N'8934974151647')
SET IDENTITY_INSERT [dbo].[History] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderDetail] ON 

INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (1, 1, N'8934974148715', 1, 101250.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (2, 17, N'8934974151647', 1, 182600.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (5, 17, N'8934974158721', 1, 176000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (6, 19, N'8934974158721', 1, 176000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (7, 19, N'8794069305344', 3, 105000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (9, 21, N'8934974148715', 2, 101250.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (10, 22, N'8934974151647', 1, 182600.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (11, 23, N'8934974162155', 3, 57400.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (12, 24, N'8934974166122', 3, 79800.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (13, 25, N'8934974160328', 1, 189000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (14, 25, N'8934974164135', 3, 92400.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (15, 26, N'8934974158721', 1, 176000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (16, 26, N'8934974151647', 1, 182600.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (17, 27, N'8934974160328', 1, 189000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (18, 28, N'8934974179978', 1, 324000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (19, 28, N'8934974176428', 1, 84000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (20, 28, N'8934974166122', 1, 79800.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (21, 29, N'8934974158721', 1, 176000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (22, 29, N'8934974151647', 9, 182600.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (23, 30, N'8934974164135', 1, 92400.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (24, 30, N'8934974176428', 5, 84000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (25, 31, N'8934974179978', 6, 324000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (26, 32, N'8935235240483', 1, 120000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (27, 32, N'8935244876437', 1, 24500.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (28, 33, N'8794069305344', 1, 105000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (29, 33, N'8934974158721', 6, 176000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (30, 34, N'8935244866032', 4, 24500.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (31, 34, N'8934974160328', 3, 189000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (32, 35, N'8935244865882', 1, 24500.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (33, 35, N'8935244868449', 5, 24500.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (34, 35, N'8934974160328', 3, 189000.0000)
INSERT [dbo].[OrderDetail] ([order_detail_id], [order_id], [isbn], [quantity], [price]) VALUES (35, 36, N'8934974151647', 4, 182600.0000)
SET IDENTITY_INSERT [dbo].[OrderDetail] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (1, N'phucnaoto', 8, CAST(N'2024-12-06' AS Date), N'Thiên Phúc', N'Thống Nhất, Đồng Nai', N'Cash', N'DELIVERED', 101250.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (17, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thiên Phúc', N'Thống Nhất, Đồng Nai', N'Cash', N'DELIVERED', 358600.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (19, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thiên Phúc', N'79 Man Thiện, Hiệp Phú, Thủ Đức', N'Cash', N'IN_PROGRESS', 670000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (21, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thiên Phúc', N'79 Man Thiện, Hiệp Phú, Thủ Đức', N'Cash', N'IN_PROGRESS', 270000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (22, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thiên Phúc', N'79 Man Thiện, Hiệp Phú, Thủ Đức', N'Cash', N'IN_PROGRESS', 220000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (23, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thiên Phúc', N'79 Man Thiện, Hiệp Phú, Thủ Đức', N'Cash', N'IN_PROGRESS', 210000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (24, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thiên Phúc', N'79 Man Thiện, Hiệp Phú, Thủ Đức', N'Cash', N'CANCELED', 285000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (25, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thien Phuc Hung Loc', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', N'Cash', N'DELIVERED', 496200.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (26, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thien Phuc', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', N'Cash', N'CONFIRMED', 388600.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (27, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thien Phuc', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', N'Cash', N'PENDING', 219000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (28, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thien Phuc', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', N'Cash', N'DELIVERED', 517800.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (29, N'phucnaoto', 8, CAST(N'2024-12-08' AS Date), N'Thien Phuc', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', N'Cash', N'DELIVERED', 1849400.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (30, N'nnthienphuc', 8, CAST(N'2024-12-08' AS Date), N'Nguyen Ngoc Thien Phuc', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', N'Cash', N'IN_PROGRESS', 542400.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (31, N'nnthienphuc', 8, CAST(N'2024-12-08' AS Date), N'Nguyen Ngoc Thien Phuc', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', N'Cash', N'CONFIRMED', 1974000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (32, N'nnthienphuc', 8, CAST(N'2024-12-08' AS Date), N'Nguyen Ngoc Thien Phuc', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', N'Cash', N'PENDING', 174500.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (33, N'phucnaoto', 8, CAST(N'2024-12-09' AS Date), N'Thien Phuc', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', N'Cash', N'DELIVERED', 1191000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (34, N'nnthienphuc', 8, CAST(N'2024-12-09' AS Date), N'Nguyen Ngoc Thien Phuc', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', N'Cash', N'PENDING', 695000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (35, N'nnthienphuc', 8, CAST(N'2024-12-09' AS Date), N'Nguyen Ngoc Thien Phuc', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', N'Cash', N'PENDING', 744000.0000)
INSERT [dbo].[Orders] ([order_id], [user_id], [promotion_id], [order_date], [receiver], [address], [payment_method], [order_status], [total_price]) VALUES (36, N'nnthienphuc', 8, CAST(N'2024-12-09' AS Date), N'Nguyen Ngoc Thien Phuc', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', N'Cash', N'PENDING', 760400.0000)
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([promotion_id], [promotion_name], [start_date], [end_date], [condition], [discount_percent]) VALUES (8, N'Không khuyến mãi', CAST(N'2024-01-01' AS Date), CAST(N'3000-01-01' AS Date), 0.0000, 0)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
GO
SET IDENTITY_INSERT [dbo].[Publisher] ON 

INSERT [dbo].[Publisher] ([publisher_id], [publisher_name]) VALUES (1, N'NXB Kim Đồng')
INSERT [dbo].[Publisher] ([publisher_id], [publisher_name]) VALUES (2, N'NXB Thanh Niên')
INSERT [dbo].[Publisher] ([publisher_id], [publisher_name]) VALUES (4, N'NXB Thế Giới')
INSERT [dbo].[Publisher] ([publisher_id], [publisher_name]) VALUES (5, N'NXB Văn Học')
SET IDENTITY_INSERT [dbo].[Publisher] OFF
GO
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (N'admin', N'Administrator')
INSERT [dbo].[Role] ([role_id], [role_name]) VALUES (N'staff', N'Staff')
GO
INSERT [dbo].[Staff] ([staff_id], [full_name], [email], [phone], [id_card], [role_id], [gender], [birthday], [address], [pwd], [is_active], [is_quit]) VALUES (N'nnthienphuc', N'Nguyen Phuc', N'nnthienphuc@gmail.com', N'0397357111', N'075890009271', N'admin', 0, CAST(N'2003-08-16' AS Date), N'Hung Nhon, Hung Loc, Thong Nhat, Dong Nai', N'$2a$10$awDw45R/ho4KzveITl.Pg.EQQBb1NPhZfmTh3Rdyp7eYLvkt336Qi', 1, 0)
INSERT [dbo].[Staff] ([staff_id], [full_name], [email], [phone], [id_card], [role_id], [gender], [birthday], [address], [pwd], [is_active], [is_quit]) VALUES (N'phucnaoto', N'Thien Phuc', N'phucnaoto@gmail.com', N'0792131511', N'056789990921', N'staff', 0, CAST(N'2003-08-16' AS Date), N'Man Thien, Thu Duc', N'$2a$10$gx3j21vx1CpTmtk0gToKTOR6KS.6e4jpmoOwZf876S2JnRJiZM9QK', 1, 0)
GO
INSERT [dbo].[User] ([user_id], [email], [full_name], [gender], [birthday], [pwd], [address], [is_active], [phone]) VALUES (N'nnthienphuc', N'nnthienphuc@gmail.com', N'Nguyen Ngoc Thien Phuc', 0, CAST(N'2003-08-16' AS Date), N'$2a$10$7RORd/dYCvGYugdH6ESkSORZOa3vtFfJjz6NwW5ckFI0wTBAknmVa', N'239 Hưng Thạnh, Hưng Lộc, Thống Nhất, Đồng Nai, Việt Nam', 1, N'0397357001')
INSERT [dbo].[User] ([user_id], [email], [full_name], [gender], [birthday], [pwd], [address], [is_active], [phone]) VALUES (N'phucnaoto', N'phucnaoto@gmail.com', N'Thien Phuc', 0, CAST(N'2003-08-16' AS Date), N'$2a$10$HyX2CachQPPwyUgJgdngq.gUDdpCF0zQwpxeyk8tMTVcIUtdE/kka', N'79 Man Thiện, Hiệp Phú, Thủ Đức, TPHCM', 0, N'0792131577')
INSERT [dbo].[User] ([user_id], [email], [full_name], [gender], [birthday], [pwd], [address], [is_active], [phone]) VALUES (N'songnguyendev', N'songnguyen.dev@gmail.com', N'Tran Song Nguyen', 1, CAST(N'2003-07-17' AS Date), N'$2a$10$BmDAnYKgLbKLlOh0BL14pulbE25wt/8IMPV8cN6iMEXnYfaxrWptq', N'97 Man Thien, Hiep Phu, Thu Duc, TPHCM', 1, N'0987654321')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Author]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Author] ADD  CONSTRAINT [IX_Author] UNIQUE NONCLUSTERED 
(
	[author_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Cart]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Cart] ADD  CONSTRAINT [IX_Cart] UNIQUE NONCLUSTERED 
(
	[isbn] ASC,
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_CategoryName]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Category] ADD  CONSTRAINT [IX_CategoryName] UNIQUE NONCLUSTERED 
(
	[category_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_OrderDetail]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[OrderDetail] ADD  CONSTRAINT [IX_OrderDetail] UNIQUE NONCLUSTERED 
(
	[order_id] ASC,
	[isbn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_PublisherName]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Publisher] ADD  CONSTRAINT [IX_PublisherName] UNIQUE NONCLUSTERED 
(
	[publisher_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_IDCard]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [IX_IDCard] UNIQUE NONCLUSTERED 
(
	[id_card] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Phone]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [IX_Phone] UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_StaffEmail]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [IX_StaffEmail] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Email]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [IX_Email] UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserPhone]    Script Date: 09-Dec-24 4:44:04 PM ******/
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [IX_UserPhone] UNIQUE NONCLUSTERED 
(
	[phone] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_Cover]  DEFAULT ((0)) FOR [cover]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_DiscountPercent]  DEFAULT ((0.0)) FOR [discount_percent]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_IsDiscount]  DEFAULT ((0)) FOR [is_discount]
GO
ALTER TABLE [dbo].[Book] ADD  CONSTRAINT [DF_Book_IsDiscontinued]  DEFAULT ((0)) FOR [is_discontinued]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Order_Date]  DEFAULT (getdate()) FOR [order_date]
GO
ALTER TABLE [dbo].[Role] ADD  CONSTRAINT [DF_MasterRole_RoleID]  DEFAULT ((0)) FOR [role_id]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF_StaffAccount_RoleID]  DEFAULT ('staff') FOR [role_id]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF_StaffAccount_Gender]  DEFAULT ((0)) FOR [gender]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF_Staff_is_active]  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF_StaffAccount_IsQuit]  DEFAULT ((0)) FOR [is_quit]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_gender]  DEFAULT ((0)) FOR [gender]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_is_active]  DEFAULT ((0)) FOR [is_active]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author] FOREIGN KEY([author_id])
REFERENCES [dbo].[Author] ([author_id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Author]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Category] FOREIGN KEY([category_id])
REFERENCES [dbo].[Category] ([category_id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Category]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Publisher] FOREIGN KEY([publisher_id])
REFERENCES [dbo].[Publisher] ([publisher_id])
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Publisher]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Book] FOREIGN KEY([isbn])
REFERENCES [dbo].[Book] ([isbn])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Book]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_User]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_Book] FOREIGN KEY([isbn])
REFERENCES [dbo].[Book] ([isbn])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_Book]
GO
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_User]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Book] FOREIGN KEY([isbn])
REFERENCES [dbo].[Book] ([isbn])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Book]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetail_Order] FOREIGN KEY([order_id])
REFERENCES [dbo].[Orders] ([order_id])
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [FK_OrderDetail_Order]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Order_Promotion] FOREIGN KEY([promotion_id])
REFERENCES [dbo].[Promotion] ([promotion_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Order_Promotion]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Order_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Order_User]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_Book] FOREIGN KEY([isbn])
REFERENCES [dbo].[Book] ([isbn])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_Book]
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD  CONSTRAINT [FK_Rating_User] FOREIGN KEY([user_id])
REFERENCES [dbo].[User] ([user_id])
GO
ALTER TABLE [dbo].[Rating] CHECK CONSTRAINT [FK_Rating_User]
GO
ALTER TABLE [dbo].[SatisfyProduct]  WITH CHECK ADD  CONSTRAINT [FK_SatisfyProduct_Book] FOREIGN KEY([isbn])
REFERENCES [dbo].[Book] ([isbn])
GO
ALTER TABLE [dbo].[SatisfyProduct] CHECK CONSTRAINT [FK_SatisfyProduct_Book]
GO
ALTER TABLE [dbo].[SatisfyProduct]  WITH CHECK ADD  CONSTRAINT [FK_SatisfyProduct_History] FOREIGN KEY([history_id])
REFERENCES [dbo].[History] ([history_id])
GO
ALTER TABLE [dbo].[SatisfyProduct] CHECK CONSTRAINT [FK_SatisfyProduct_History]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [FK_StaffAccount_MasterRole] FOREIGN KEY([role_id])
REFERENCES [dbo].[Role] ([role_id])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [FK_StaffAccount_MasterRole]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_BookDiscountPercent] CHECK  (([discount_percent]>(0.0) AND [discount_percent]<(1.0)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_BookDiscountPercent]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_Cover] CHECK  (([cover]=(0) OR [cover]=(1)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_Cover]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_IsDiscontinued] CHECK  (([is_discontinued]=(0) OR [is_discontinued]=(1)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_IsDiscontinued]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_IsDiscount] CHECK  (([is_discount]=(0) OR [is_discount]=(1)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_IsDiscount]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_Price] CHECK  (([price]>(10000)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_Price]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_Quantity] CHECK  (([quantity]>=(0)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_Quantity]
GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [CK_YearOfPublication] CHECK  (([year_of_publication]>(1900) AND [year_of_publication]<(2040)))
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [CK_YearOfPublication]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_OrderDetailPrice] CHECK  (([price]>(10000)))
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [CK_OrderDetailPrice]
GO
ALTER TABLE [dbo].[OrderDetail]  WITH CHECK ADD  CONSTRAINT [CK_OrderDetailQuantity] CHECK  (([quantity]>(0)))
GO
ALTER TABLE [dbo].[OrderDetail] CHECK CONSTRAINT [CK_OrderDetailQuantity]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [CK_TotalPrice] CHECK  (([total_price]>(10000)))
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [CK_TotalPrice]
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [CK_Date] CHECK  (([start_date]<[end_date]))
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [CK_Date]
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD  CONSTRAINT [CK_DiscountPercent] CHECK  (([discount_percent]>=(0.0)))
GO
ALTER TABLE [dbo].[Promotion] CHECK CONSTRAINT [CK_DiscountPercent]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [CK_StaffBirthday] CHECK  ((datediff(year,[birthday],getdate())>=(18)))
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [CK_StaffBirthday]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [CK_Birthday] CHECK  ((datediff(year,[birthday],getdate())>=(18)))
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [CK_Birthday]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Book', @level2type=N'COLUMN',@level2name=N'quantity'
GO
USE [master]
GO
ALTER DATABASE [OnlineBookStore] SET  READ_WRITE 
GO
