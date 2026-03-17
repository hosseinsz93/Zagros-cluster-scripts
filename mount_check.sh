for node in $(pbsnodes -a | grep "Mom =" | awk '{print $3}'); do
    ssh $node "df -h | grep lustre" >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "  $node missing Lustre"
    fi
done