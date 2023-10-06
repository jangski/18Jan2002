//Deklarasi kontrak smart contract perpustakaan
contract perpustakaan
    //struct untuk menyimpan informasi buku
    struct buku {
        string judul;
        uint256 tahunDibuat;
        string penulis;
    }

    //mapping untuk menghubungkan ISBN dengan informasi buku
    mapping(string=>Buku)private bukuData;

    //mapping untuk mengidentifikasi admin
    mapping(address=>bool)private isAdmin;

    //modifikator untuk memastikan hanya admin yang dapat mengakses fitur tertentu 
    modifier hanyaAdmin(){
        require(isAdmin[msg.sender],"hanya admin yang dapat mengakses fitur ini");
        _;
    }

    //Fungsi untuk menambahkan buku
    function tambahBuku(string memory isbn,string memory judul,uint256 tahunDibuat,string memory penulis)public hanyaAdmin{
        //pastikan ISBN unik sebelum menambahkan buku
        require(bukuData[isbn].tahunDibuat==0,"Buku dengan ISBN ini sudah ada");

        bukuData[isbn]=Buku(judul,tahunDibuat,penulis);
    }

    //fungsi untuk mengupdate buku
    function updateBuku(string memory isbn,string memory judul,uint256 tahunDibuat,string memory penulis) public hanyaAdmin{
        //Pastikan buku dengan ISBN ini sudah ada sebelum diupdate
        require(bukuData[isbn].tahunDibuat!=0,"Buku dengan ISBN ini tidak ditemukan");

        bukuData[isbn] = Buku(judul,tahunDibuat,penulis);
    }

    //Fungsi untuk menghapus buku
    function hapusBuku(string memory isbn) public hanyaAdmin {
        //Pastikan buku dengan ISBN ini sudah ada sebelum dihapus
        require(bukuData[isbn].tahunDibuat !=0,"Buku dengan ISBN ini tidak ditemukan");

        delete bukuData[isbn];
    }

    //Fungsi untuk mendapatkan data buku berdasarkan ISBN
    function getDataBuku(string memory isbn) public view returns(string memory,uint256,string memory){
        Buku storage buku = bukuData[isbn];
        require(buku.tahunDibuat !=0,"Buku dengan ISBN ini tidak ditemukan");

        return(buku.judul,buku.tahunDibuat,buku.penulis);
    }

    //Fungsi untuk menambahkan admin
    function tambahAdmin(address adminAddress) public hanyaAdmin {
        isAdmin[adminAddress] = true;
    }

    //Fungsi untuk menghapus admin
    function hapusAdmin(address adminAddress) public hanyaAdmin {
        isAdmin[adminAddress] = false;
    }
}