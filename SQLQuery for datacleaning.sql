
--Cleaning data in queries
select * from
Nashvillehousing
--Standardize date formate
select saledate, convert(date,saledate)
from Nashvillehousing

alter table nashvillehousing
add saledateconverted date;
update Nashvillehousing
set saledateconverted =convert(date,saledate)

--Populate columns (property address and owners address) 
select *
from Nashvillehousing
--where propertyaddress is null
order by parcelID

select a.parcelID, a.propertyAddress, b.parcelID, b.propertyAddress, ISNULL(a.propertyAddress,b.propertyAddress)
from nashvillehousing a
join nashvillehousing b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.Propertyaddress is null

update a
set propertyaddress = isnull(a.propertyaddress, b.propertyaddress)
from nashvillehousing a
join nashvillehousing b
on a.parcelid = b.parcelid
and a.uniqueid <> b.uniqueid
where a.Propertyaddress is null

--Breaking out column contents into two or more columns (propertyAddress and ownerAdress)
select Propertyaddress, owneraddress
from Nashvillehousing

select propertyaddress,
substring(propertyaddress, 1, Charindex(',',Propertyaddress)-1) as address,
substring(propertyaddress, Charindex(',', Propertyaddress)+1, len(propertyaddress)) as city
from NashvilleHousing

alter table NashvilleHousing
add propertysplitaddress nvarchar(255);
update NashvilleHousing
set propertysplitaddress = substring(propertyaddress, 1, Charindex(',',Propertyaddress)-1) 

alter table NashvilleHousing
add propertysplitcity nvarchar(255);
update NashvilleHousing
set propertysplitcity = substring(propertyaddress, Charindex(',',Propertyaddress)+1,len(propertyaddress)) 


select
parsename(replace(owneraddress,',','.'),3),
parsename(replace(owneraddress,',','.'),2),
parsename(replace(owneraddress,',','.'),1)
from NashvilleHousing

alter table NashvilleHousing
add ownersplitaddress nvarchar(255);
update NashvilleHousing
set ownersplitaddress =parsename(replace(owneraddress,',','.'),3)

alter table NashvilleHousing
add ownersplitcity nvarchar(255);
update NashvilleHousing
set ownersplitcity=parsename(replace(owneraddress,',','.'),2)

alter table NashvilleHousing
add ownersplitstate nvarchar(255);
update NashvilleHousing
set ownersplitstate=parsename(replace(owneraddress,',','.'),1)

--change content in a column(Y and N to yes and no in "soldasvacant" coloumn)
select distinct(soldasvacant), count(soldasvacant)
from NashvilleHousing
group by soldasvacant
order by 2

select soldasvacant,
case when soldasvacant ='Y' then 'Yes'
	 when soldasvacant = 'N' then 'No'
	 else soldasvacant
	 end
	 from NashvilleHousing

update NashvilleHousing
set soldasvacant =case when soldasvacant ='Y' then 'Yes'
	 when soldasvacant = 'N' then 'No'
	 else soldasvacant
	 end

--Remove duplicates
select *
from NashvilleHousing



--Delete unused columns
Alter Table NashvilleHousing
Drop column propertyaddress, owneraddress,taxdistrict,saledate